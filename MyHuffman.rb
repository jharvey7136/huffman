
#BEGIN PROGRAM

#Classes:
# => NodeQueue: priority class for the nodes
# => Node:  class to hold the nodes in the tree
# => MyHuffman: represents the tree with which we perform the encoding


#----------begin priority queue class for nodes------------------#
class NodeQueue
  def initialize
    @queue = []
  end

  def enqueue node
    @queue << node
    @queue = @queue.sort_by{|x|[-x.weight,x.val.size]}
  end

  def dequeue
    @queue.pop
  end

  def size
    @queue.size
  end
end
#----------end priority queue class for nodes------------------#


##################################################################


#---------begin class to hold nodes in the huffman tree------------#
class Node
  attr_accessor :val,:weight,:left,:right

  def initialize(val="",weight=0)
    @val,@weight = val,weight
  end

  def children?
    return @left || @right
  end
end
#---------end class to hold nodes in the huffman tree------------#


##################################################################


# HuffmanTree represents the tree with which we perform the encoding
class MyHuffman

     # initialize the tree based on data
     def initialize s
       @freqs = count_frequencies(s)      #call count_frequencies method
       @root = huffman                    #call huffman method
     end


#encode the given data
#---------------------------begin encode string method-----------------------#
     def encode_string s
       s.downcase.split(//).inject("") do |code,char|
         code + encode_char(char)
       end
     end
#---------------------------end encode string method-----------------------#



     private
      # this method encodes a given character based on our
      # tree representation
      def encode_char char
        node = @root
        coding = ""

        # encode to 0 if only one character
        if !@root.children?
          return "0"
        end

        # we do a binary search, building the representation
        # of the character based on which branch we follow
        while node.val != char
          if node.right.val.include? char
            node = node.right
            coding += "1"
          else
            node = node.left
            coding += "0"
          end
        end
        coding
      end


#-------------------------begin count frequencies method-------------------------#
      # get character frequencies in a given string s
      def count_frequencies s
        s.downcase.split(//).inject(Hash.new(0)) do |hash,item|
          hash[item] += 1
          hash
        end
      end
#-------------------------end count frequencies method-------------------------#


# build huffmantree using the priority queue method
#----------------------begin huffman method----------------------------#
      def huffman
        queue = NodeQueue.new

        # build a node for each character and place in pqueue
        @freqs.keys.each do |char|
          queue.enqueue(Node.new(char,@freqs[char]))
        end

        while !queue.size.zero?

          # if only one node exists, it is the root. return it
          return queue.dequeue if queue.size == 1

          # dequeue two lightest nodes, create parent,
          # add children and enqueue newly created node
          node = Node.new
          node.right = queue.dequeue
          node.left = queue.dequeue
          node.val = node.left.val+node.right.val
          node.weight = node.left.weight+node.right.weight
          queue.enqueue node
        end
      end
#----------------------end huffman method----------------------------#

    end  #end private



    if __FILE__ == $0
   require 'enumerator'

   s = ARGV.join(" ")       # get string from user
   tree = MyHuffman.new s   # build tree

   # get encoded data and split into bits
   code = tree.encode_string(s)
   encoded_bits = code.scan(/\d{1,8}/)

   # output
   puts
   puts "Original"
   puts s
   puts
   puts "Encoded"
   encoded_bits.each_slice(5) do |slice|
     puts slice.join(" ")
   end

 end




 #END PROGRAM
