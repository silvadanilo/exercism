class Node:
    def __init__(self, value, succeeding=None, previous=None):
        self.value = value
        self.succeeding = succeeding
        self.previous = previous

class LinkedList:
    def __init__(self):
        self.tail = Node(None)
        self.head = Node(None, self.tail)
        self.tail.previous = self.head
        self.length = 0

    def push(self, value):
        self._insert(self.tail.previous, self.tail, value)

    def unshift(self, value):
        self._insert(self.head, self.head.succeeding, value)

    def pop(self):
        return self._remove(self.tail.previous)

    def shift(self):
        return self._remove(self.head.succeeding)

    def delete(self, value):
        node = self.head
        while node != None:
            if node.value == value:
                return self._remove(node)

            node = node.succeeding

        raise ValueError("Value not found")

    def __iter__(self):
        node = self.head.succeeding
        while node.succeeding != None:
            yield node.value
            node = node.succeeding

    def _insert(self, previous, succeeding, value):
        node = Node(value, previous=previous, succeeding=succeeding)
        succeeding.previous = node
        previous.succeeding = node
        self.length += 1

    def _remove(self, node):
        if self.length == 0:
            raise IndexError("List is empty")

        node.previous.succeeding = node.succeeding
        node.succeeding.previous = node.previous
        self.length -= 1

        return node.value

    def __len__(self):
        return self.length
