Return-Path: <linux-kernel+bounces-527241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB0A408CC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69C37AD90D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312E146588;
	Sat, 22 Feb 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jfw23gZo"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6953365;
	Sat, 22 Feb 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231902; cv=none; b=Dnwz0HqKzCgg4utQT91q8kV1fta6BDd4I97+XmMVjh6L2h9LaYmalPnYL2kiNbnZeS5XA7FjOd+3GzVcfDLrd/2ZLG+7GcR9nmHmqERqHnB7ud5g6jBS4QToPBRRpyjF9z/eF0R7qaJZbzjDvU4UlivywKKPmYbbQeDixh2SJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231902; c=relaxed/simple;
	bh=CXNcdYrn1tkb6ObOF1F72eS1mkhkerPs/MCI9WlxYdI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=r08vSiF29ujdOqhD7R3r8U5YHHImyT6Y1iBye+iwYbMj8kqYXUecNNbXTp5x4qaysliloDPoAo5Kfb4SxWhwuc4OwWYndwA7clQHCVwAuFSyixJPBSguXTwyGzdoiLkGNbdEljxvIOPtpwBLsXXbKv/GUtBH3ldpHcS6Jk2Lp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jfw23gZo; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740231883; x=1740836683; i=markus.elfring@web.de;
	bh=0wTZa0Kkcr3qmm6VKMjFNVqBA4FCJpNUSxDAb0tLRbE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jfw23gZoxS1V7FWKPnfCM5OX0gfh04PtRmvmN8BFsHvFwMlRBHcnjq7FOXgtPFkQ
	 xHv80RTNR6GhJUWV7NKJoqDQt+eyqiPMeW/bbHiBXxOZwa9CjN9qKVM0wMkC0Tiy/
	 rZaqIhkdkIMdrpOmgaS7Rf5MBFUFenVpPkJMwBuPy3PmRuALDr3Wgd1Jc54lSKgj7
	 Nh3AecW4NnJXMrzgGlP4v3PUHAg17cYomP5fWhMhbg+9NRUBhffAJxk6zGzTXXvMt
	 PkZzx5EVN5ce77mlpt8qs/4qCCPLm+ZlFK54LSP9pvVPea/dbNAS2lLJmYdnHGrTE
	 4k/LIaQjlJE7NZFnzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.22]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1t6AXA1H9n-00ec4q; Sat, 22
 Feb 2025 14:44:43 +0100
Message-ID: <04032bab-ad6f-4ef1-9600-27554233b9a1@web.de>
Date: Sat, 22 Feb 2025 14:44:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel-janitors@vger.kernel.org, cocci@inria.fr
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ricardo Ribalda <ribalda@chromium.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?=5BRFC=5D_Extending_usage_of_attribute_=E2=80=9C=5F=5Ffre?=
 =?UTF-8?B?ZeKAnSAod2l0aCBTbVBMKT8=?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0KBopMn0YCRV6z39DeA4axqW2lNIPDu54nztBRouELgFmszUaBF
 Hxp/TrdBhx352nQh+jBj37RA7sPaWckW1zfTtp3lGuG5w/QQbteehMZUr6ZHmQClSe0HhHE
 h6ZEBJS7X4LwRNLfvc/vachUjwLDXVcbVt/bBCOjvcMwJOLEE49okhqsMiC5unbYaWsZcFV
 TDg6EdQdZ/6t0SOvBQM3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XuauyZXjj4g=;Ex7yATVTFt+De4YPVdosrs6YTWy
 9RTnhWutFuZVHTgC3/ShbhQ9sB92rjVsKWFsAhIqAH+57VO8hUHZvqbOsC+YKKOxCpIfX6ncr
 4n4qPiA+mUW4L1SBNojtHN3UNH3qmYegmaR37wBfUs8JQTRBsSnFJIkD4uKnvX38fHcYl4PgK
 fOED2OdsNATHIU2T7T0Dlthul3X+vjMsN/MaGBfbi1VpjCCMXsofoLF+TbEExPZLYhRaKV4O4
 Vk3+IwDXYP1HnD9+8elEcCAqGXDTknukvFnlJ1x1J4N+i8jNquSlPqf/OPCXz+g3270hwLvlL
 BYi7+KE7MSmX83msfHZ4b1lgAw/ZSst3WBehkU9BIgWaMQcOOt/Mf9pTIao1h7qVJbWxFpY8T
 A1nojOhh8H6h4mZyPVZ34M4+kYcZKb5oti9ISExhuPKfFefCxtBv9XtmoTGySIi3PGiweC2ON
 k0sRDYWQindDK3jTS1VDaAZBUyDmahk4gn9u3/j9NPf4FARmXWU14KAY29MqCezWPnwZD59/7
 ko2b17rA1mxa1HU4XT7uJq1KOuwYcVX24QCJbNHZQHws/8DetLUFu26/PlGvPoFl2zZB8Prcz
 5YoNdqsSe2mRRDSZUEABGYfT6RkJ0HT9udcCrALS5PwMl8zZB4FE3wHqmb9wivuKZ+cyRIOUj
 uOugPnPFq2SL1aNUfxLQuHtEDDMAcTLnQku9rr/82reomSLJ+gdhLV0NgnG/gus6InvvNBFLB
 PslQhXPx02KbcKaJvrpqIylzDU8i/H9ewiAMnWvJrd+Csd2iE2eCCrUcSzL9LNdjW1I0RINRW
 EmVZhLM9etGJGrFAi4fJ2pD1Bk9AHXBKBwN6AziJUVelO3q3OhugF8/v9YKPrqAS9i2msKuUh
 ToEhRn/Lj2OioCr8y1v1t5L5rgioY0cK26ZIj0X84i5cBILoYIqXt62m0wH0hG+8ns3GNuMYJ
 iPxFX6WCWZkpiH21bT+phAkAJ6lVqWSghnPFm4w3ik5gZTxq/3yjuBjekR1G0y8B6auV0wi9+
 Cbkc97tQsV3V3GfL1OZ6c7RoJfOj0DswgdwwRuNrHuSWEOUf5A0og60rhbBxOsOo2u8PF9qhY
 /BtKQbeS/D8ur8WMBovd9kftGVYBTGn3C2vOFPHlc7hSY6Wfm1DB2jnz0wvIqNs9G3dhgpO5P
 SjyPJqVG3jBdpa3wsZY/MwlQu15nr6kYL0fO4to/nsYE2FW9gas94fhJjy1PgsETLZmTc48gO
 Ado8VpWpIL4Ztpqgd+hLjQBdFvsJwDWcbkvUnIolqulSPiMHczViHIltBzZD8YEk4oR8+6AwD
 0Yh8MKQGuZarv8a6kz/thWhWpP9q5jwVIpJbvInO1Z9oYFT6Tdls6AoX+ERwQ4IR+jmI33Gef
 BaqNKv4A3sCbzyY8j3c5jL2klW1UnZDyQZm2NPa70qWFrHlVgdmBqTfjI2IQVP5GdmH7nCM92
 4WkM8FmmHQOxlDsVhIeiB1h/4hZg=

Hello,

Various software extensions were developed based on the programming langua=
ge =E2=80=9CC=E2=80=9D.

* Object-oriented software development became supported with some programm=
ing languages.

* Scope-based resource management became also supported for Linux componen=
ts
  to some degree.
  See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
  Introduce __cleanup() based infrastructure") from 2023-06-26.
  Some contributors are still struggling with corresponding collateral evo=
lution.

  But a well-known source code cross-referencer can point out that an iden=
tifier
  like =E2=80=9C__free=E2=80=9D is used in 281 source files so far.
  https://elixir.bootlin.com/linux/v6.14-rc3/A/ident/__free

  See also a previous presentation of analysis results:
  https://lore.kernel.org/cocci/e8bf7b33-01da-43fb-b71e-cd86a02be2e6@web.d=
e/
  https://sympa.inria.fr/sympa/arc/cocci/2024-10/msg00011.html
  https://lkml.org/lkml/2024/10/17/1393

  Thus there can be a need to adapt advice which can be offered also by
  coccicheck scripts.
  Example:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
scripts/coccinelle/free/put_device.cocci?h=3Dv6.14-rc3#n2

  The attribute =E2=80=9C__free=E2=80=9D belongs to properties of variable=
 definitions.
  Source code search approaches can eventually be adjusted also by the mea=
ns of
  the semantic patch language.
  Corresponding software run time characteristics might become more intere=
sting.
  How will development interests evolve accordingly?


Regards,
Markus

