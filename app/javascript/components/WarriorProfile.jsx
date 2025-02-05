import React from 'react'
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from './ui/card'

const WarriorProfile = ({ warrior }) => {
  return (
    <div className="max-w-4xl mx-auto p-4">
      <Card>
        <CardHeader>
          <CardTitle>{warrior.fullName}</CardTitle>
          <CardDescription>{warrior.academy}</CardDescription>
        </CardHeader>
        <CardContent>
          {/* We'll add more content here in the next step */}
        </CardContent>
      </Card>
    </div>
  )
}

export default WarriorProfile