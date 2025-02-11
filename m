Return-Path: <linux-kernel+bounces-509917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FCFA315FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6DB1889F87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B257265617;
	Tue, 11 Feb 2025 19:52:00 +0000 (UTC)
Received: from smtp100.iad3b.emailsrvr.com (smtp100.iad3b.emailsrvr.com [146.20.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047B265602
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303519; cv=none; b=QFVYWtVSHFIKMIQTumd7MBy0w11U9FYv07lRvGai0QQNIia5KjV3APCC9L7XC2uhBpMvAWAPNWv0BGbcVbPGBNn/rjCFGe4bGZ06sbKS0bewub0DEho0v5yZci+/STNnmX99i1JpktmVfmDZPiTohoVJgPMzYW/HDKqmjXwUQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303519; c=relaxed/simple;
	bh=9Rk9Ban75IohzioQM36FzSu4W/ye50Kax9T901Zpxi8=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uG3kEYcnwzvjcBFjVPsbIqf39M1b/PYGQ9zRF6vZsKf6FHMkYPhsAUGZkeUDT5zRk7PCXwvUH7I4c1g7DJUANbxK7f5f5eFZNUa3ZtAqUlrJjefM4MXCb8pig+CajJKD9/CdYkdfWwhXX2LVKFQUqUtWEC3IKUoqO5q74eX4KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leadexpolink.tech; spf=pass smtp.mailfrom=leadexpolink.tech; arc=none smtp.client-ip=146.20.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leadexpolink.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leadexpolink.tech
X-Auth-ID: betsy.toya@leadexpolink.tech
Received: by smtp21.relay.iad3b.emailsrvr.com (Authenticated sender: betsy.toya-AT-leadexpolink.tech) with ESMTPSA id 1546B201B3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:33:04 -0500 (EST)
From: "Betsy Toya" <betsy.toya@leadexpolink.tech>
To: <linux-kernel@vger.kernel.org>
References: <!&!AAAAAAAAAAAuAAAAAAAAAEeEvtmGxoZMvDmfT8OZk4sBAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AABAAAACNepBN7VImSa22272gn5xEAQAAAAA=@leadexpolink.tech>
In-Reply-To: <!&!AAAAAAAAAAAuAAAAAAAAAEeEvtmGxoZMvDmfT8OZk4sBAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AABAAAACNepBN7VImSa22272gn5xEAQAAAAA=@leadexpolink.tech>
Subject: RE: ISMRM 2025 - Preregistered attendees
Date: Tue, 11 Feb 2025 14:32:26 -0500
Message-ID: <!&!AAAAAAAAAAAuAAAAAAAAAEeEvtmGxoZMvDmfT8OZk4sBAMO2jhD3dRHOtM0AqgC7tuYAAAAAAA4AABAAAAB7MYN1HYo2TJsQCJ/efxbfAQAAAAA=@leadexpolink.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_2025_01DB7C91.DD56B170"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFFc/MwnnK5KTaQBQWv4jgzyCDDbrRujbXw
Content-Language: en-us
X-MS-TNEF-Correlator: 000000004784BED986C6864CBC399F4FC399938B0700C3B68E10F77511CEB4CD00AA00BBB6E600000000000D00006511BB06ADF97D459D0985ED6AED04EA00000000C5190000
Disposition-Notification-To: "Betsy Toya" <betsy.toya@leadexpolink.tech>
X-Classification-ID: 5aca2466-00df-43ef-be9b-f2a08f631c3a-24-1

This is a multipart message in MIME format.

------=_NextPart_000_2025_01DB7C91.DD56B170
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



Hi,

Would you like to review our best pricing offer on most recent attendees'
contacts?

Regards,
Betsy


_____________________________________________
From: Betsy Toya <betsy.toya@leadexpolink.tech> 
Sent: Monday, February 10, 2025 8:04 PM
To: linux-kernel@vger.kernel.org
Subject: ISMRM 2025 - Preregistered attendees


Hi, 

List of pre-registered Participants of International Society for Magnetic
Resonance in Medicine - ISMRM 2025.

If you're interested, I'm happy to share you Counts and Pricing details for
your review.

Attendees: Key decision makers, Clinicians, Physicists, Engineers,
Biochemists, Technologists and Students and Trainees.

List contains: Contact, Title, Company, Website, Physical Address, mobile
Number, Fax Number, SIC, Industry type, Employees, Option Emails and
Verification results.

Awaiting for your inputs,
Thanks,
Betsy Toya | Expo Coordinator

If you are not interested in my emails reply "takeout" to me.




------=_NextPart_000_2025_01DB7C91.DD56B170
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
3626OE+/b79R37G4OO9Tn3MfYi+1nThXz3bPkp/9uc04W/96f14fvft68pkPD2FPYl+hyKJRY29s
b0BydGJsO1ytsGRoMFxnrbFuoeChcHXUZTChn2XbIDWiyqPh/6OfpKmitKTSoz+nD6bNpk/zpH+i
z2Ux46Csmq2xrW//rnmitK6irQ+w37CdsB+uT/2yFDluoLVktsGu47bArJ+3oq+456dFOYSwt4Qz
shT/J1G5k4ShruO8ALkq7vG40nw5Nrkj6xG5kz+BruMwXbCVOb7lwEK3hDHCsiqoXGRliZFwnVEz
c6Hqc87hbIlgZ35xu5DC405mv7HyscOUbnDD8iDJwZZwYcIxcWydUHfwZ7lwdHC5cHNhfnDGgWzn
2yCEsMcAbXXecIiQa9DQZGN0bMWQcsfQ2kCKcMHhYceRXGFzxZBHyDBsQMkybnVtzpBhCcjwdG/J
MGRqdXN+dHRw+ZHGUbihd/C4oWkKdMWgMMUAXG5vccN3cZdwb3RlIM6AyvDUeWyW8GjuQHTSYMXq
/8fvyP/KD8sfzCO5MM8wiaDJiYFzMZ1QYWa5cNRQ98Kyd+DDAjDbIMYB0hDTxPfTYcJvw3tjuZCd
INbjxKGHw0nEpcaQbmV4dNNhfnPMsKFAl4DmkMaQd4Bp66FAzBB5zFBO2vKhgMGT39QB02HRwJ0w
3oB2zTDGkPHi8G1paJ0gweCXoMaQ9HVu3iFl0fC5UNtJ1CDSRM/kIFBsUGG5kMWgQGggRm9udMGE
dG/UEIiQ4eCJMHfYgNIQZsXh4FedIHRoQpBw0hC7xZDdQGy/wJZA43Ry4+hcZmzjVuLA5Vdi5Vdy
+eNSY2LFkMex1bHFgeeyn6Fwy4C5Yeh0zYBwZeNR/nPdkKFQ/fHh0fXw5HDqNjps6kVi6kXPcOpU
ZGff6zbssOw209DqVHbFz8bf/87/0A/RH9Iv0z/UQdZx1J//1a/Wv9fP2N/Z6b0A3b/eyP/cFJ7w
GjDNoNx39zHdONOd//dM6mDyALlQ4VDc8vyc23hb21Hp4HPhUP5hRZeAabxsU82CBsDBddQBNv+P
7wCf97XwUKEAZrawAf/8z33fE0jpYesgy4AOM9yzN/8GfwePCJppQAl/Co/fE+FA+myhMHe5UAvv
mlANHw4v/wGvAr8DzwTcr0DchglhFF//FW8WfxePGJ8E+sFm1AAP8v8bPxxPHV8ebx9/BPlpQCFY
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
gm07gMfw5DNxUDvjEDuAIrCwYBCi8HQi+Z2SbWWVj/Xf8i/4D3vP/8t/zI/Nn86vz7/Qz7DLsdD+
M9LQ0w/+7///AQgJ1v12BH0ADyAAAAALABYwAQAAAAMA3j+fTgAAAwDxPwkEAAAeAPo/AQAAAB0A
AABiZXRzeS50b3lhQGxlYWRleHBvbGluay50ZWNoAAAAAAMAAlkAABYAAwAJWQMAAAADAC2ACCAG
AAAAAADAAAAAAAAARgAAAAABhQAAAAAAAAMAPIAIIAYAAAAAAMAAAAAAAABGAAAAABCFAAAAAAAA
CwB9gAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAALAIGACCAGAAAAAADAAAAAAAAARgAAAAAO
hQAAAAAAAAMAhIAIIAYAAAAAAMAAAAAAAABGAAAAABiFAAAAAAAACwCZgAggBgAAAAAAwAAAAAAA
AEYAAAAAgoUAAAAAAAAeAMOACCAGAAAAAADAAAAAAAAARgAAAADYhQAAAQAAAAkAAABJUE0uTm90
ZQAAAAACAd2ACCAGAAAAAADAAAAAAAAARgEAAAA2AAAASQBuAFQAcgBhAG4AcwBpAHQATQBlAHMA
cwBhAGcAZQBDAG8AcgByAGUAbABhAHQAbwByAAAAAAABAAAAEAAAAIMSMhBiNYJGiiy7c7Z5ri0L
AB8OAQAAAAIB+A8BAAAAEAAAAII+tYwTnwFCtHgalstDAGICAfoPAQAAABAAAABHhL7ZhsaGTLw5
n0/DmZOLAwD+DwUAAAADAA00/T+tDgMADzT9P60OAgEUNAEAAAAQAAAA6S/rdZZQRIaDuH3lIqpJ
SAIB4mUBAAAAFAAAAP5LdUi1uIFFjUbxHPcdeDcAByqgAgHjZQEAAAAVAAAAFP5LdUi1uIFFjUbx
HPcdeDcAByqgAAAAAgF/AAEAAACNAAAAMDAwMDAwMDA0Nzg0QkVEOTg2QzY4NjRDQkMzOTlGNEZD
Mzk5OTM4QjA3MDBDM0I2OEUxMEY3NzUxMUNFQjRDRDAwQUEwMEJCQjZFNjAwMDAwMDAwMDAwRDAw
MDA2NTExQkIwNkFERjk3RDQ1OUQwOTg1RUQ2QUVEMDRFQTAwMDAwMDAwQzUxOTAwMDAAAAAAAwAG
EOnH324DAAcQ7AIAAAMAEBAAAAAAAwAREAEAAAAeAAgQAQAAAGUAAABISSxXT1VMRFlPVUxJS0VU
T1JFVklFV09VUkJFU1RQUklDSU5HT0ZGRVJPTk1PU1RSRUNFTlRBVFRFTkRFRVNDT05UQUNUUz9S
RUdBUkRTLEJFVFNZRlJPTTpCRVRTWVRPWUE8AAAAABQB

------=_NextPart_000_2025_01DB7C91.DD56B170--


