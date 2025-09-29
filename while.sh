while [ $count -gt 0 ]
do
  echo "Time left: $count"
  sleep 1 # Pause for 1 second
  count=$((count - 1)) # Decrement the count
done

echo "Times up!"