count=5
while [ $count -gt 0 ]
do
  echo "Time left: $count"
  sleep 1 # Pause for 1 second
  count=$((count - 1)) # Decrement the count
done

echo "Times up!"

while IFS= read -r line; do
    # Process each line here
    echo "Processing line: $line"

done < script-1.sh