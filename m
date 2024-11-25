Return-Path: <linux-kernel+bounces-421314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A319D8982
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A188281EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577351B4128;
	Mon, 25 Nov 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="faOHw3qO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44A1AC448;
	Mon, 25 Nov 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549153; cv=none; b=fFsgz6vScWyYVl3vIg1J/xS7+5oLn9Nh0Xb+mtc3VSrg/MhzT2EwPrWW/Xbp38WnR3XGVkyoF8et54BWl5DYb0vA4Wp2gaSzD71pcwCh2SHoJjf46yWi17cVeexGIDUl+jGQGQ5e1NKmXuGJ29LL85UdxcpL/aw0k9HFTkyW/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549153; c=relaxed/simple;
	bh=z+ueDwTi1FSEUiAFpqYNlRAcOCUi1kGZm9AIgB6v0IM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bi3BYw8pBnQUocDgi8t2AwPeicolyUqYDAO4FW9ZT8ZfoBEWxhSMIlSpw79p2YKiXzs3IbWviv6061XL+AKWttrUMNsGj7V0OoJdg96cMhxgOo5yIM22Do90SAqa8S6Jcgw0xPAmx2p+fHzT+8t7KnDH64mGi9+UEGXHkdM2Wmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=faOHw3qO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732549142; x=1733153942; i=wahrenst@gmx.net;
	bh=z+ueDwTi1FSEUiAFpqYNlRAcOCUi1kGZm9AIgB6v0IM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=faOHw3qOwAL8wWM88GMgvb8zIAdkEW5jwJUUwgW5ARf6YuETw6BAYwKodKm3K17V
	 BPA21tQOPiHzllSSYbo1AAMpMziX1OiLpHzLVt59UqAWyBU2y1/jIh+QgKZuIoczr
	 uwfbvGtDkZB68cSWjR/T0j/wlfZgFClB2vHFHmUY5/5Oa2baPp0gOcPFPt+g1ChXc
	 OC31l7vaBYWZaxTD1uwoji0JdzYAZAX4R/uoBqq4jXwrISBJJgBM9yD1eXAtX5j7P
	 rPGAS304WG7s/RW7mz9jVUPU00ojTcowzV0CflXfnjG0LcNVO0Q66umNShgN7FxLC
	 wPxFl20W06CN8VgvMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1tDTbS1GLg-00KbfN; Mon, 25
 Nov 2024 16:39:02 +0100
Message-ID: <a052fb31-c021-483d-a0a2-55fff196048f@gmx.net>
Date: Mon, 25 Nov 2024 16:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ben Gardner <bgardner@wabtec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RgvGnme+nn/BmD0pY4d2ccqxah7EVyW+j8kv0PKnuWa9CbHcfQB
 7TGHAOyCMe9hvBM5o2r2R83Pvqu0VMp/HMKA8rO8sHK6LxQ1Ll+JwWDG9RtjxB/x3+uN4R3
 35T1E8SkKJJgV7QC/f6eOY0bWKufurleqVj2hvT7BuomCZZ1aIjtrtfdgbeOwwsS2iDhowb
 989TtKMDvhAGb2ihVL+Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+btVzO60sTo=;9QMht7vsyZtfdgCsNOIqv76Dvcv
 fWkARg20JUuqvh+2yE+o9J54sw9hP/pA1cC4TuXrN01YHJnIR+RiYgtTzXrcRqzWIdvmrNCKC
 zshyI6IaJ0v71o291fcmhZMuHIELmYgdSPTStg1mA/ueeh15IHLSfjAvjbcBmjoqSlO8zcra0
 C/BtJCCFsya51hAU9V0xrKmWFBetazA8D+sdbF35MBUtwDQugiLm0W9V20G62IZkkUbMc9uRM
 Gj49ZVi9KVWZaTpVdzfVcSI8cYpT9TmcBQKOEjdH6gSenSefd73hV/u6EkwaqMJEKkqWKXEsd
 TZAPw8O8NgTejjfjr1+yAhvi+WHPoVOfnwVKhgZXiCOuYdEUVgj4QLSPCmcQo/wT8HFEIsTSc
 FTuUn3ZXXKNt42df7gg8EAe5SE+8KAYNIGFad8xPefCp1i27Q0nVr4AF05PCv3yNsO+UuGx+Y
 dV4OZV3seTQ3oInjkPKEIGfDpAQP8TiW45tyddafmMfwYNjgq9epfI/PN3ilMkxfQ1y8VE2VD
 /aobLVt8s93cvdX01Tc3h+LMumX2WmKQ+vD6VYqxzUzfesBTBL3DDmzJL7xVyI0bzBnno4izI
 y1dwJe7prrbe+527zqZHBsNZKbsFrPmWNkhZ12DncJir+LlerxCV4Mnn6u9hZKc6yKg2QNQ+Z
 I1Pi2pfSOjlizdebACbUCzmlF6zeGPCL2smHljNG1YJLlyqRQzVKVtRp9HdIlekESGQwG2oCH
 0Goqi0s68cYngQy9gwUIW8rYngi2Ep8hjzzp8ceMUWRqLvj1aEqVcs2Xs+ZY4AiB1LU+7bebB
 tYeGv5UMb3JJAymF713DeEaDxfvvCUxYPMcb6b5G+AOI82FPdYsgfhVw9afLQp75N7kK65HPj
 xgC35MiCc4+0DpcL3iYRV9yrSIqgFqnxFsbj4t3Z6iEBxkpFX7NguKKl+

Hi Kry=C5=A1tof,

 > From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
 >
 > ds2482 has a VCC pin, accepting 2.9-5.5 V.
 >
 > Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Sorry, I'm not able to reply from my chargebyte address.

I'm fine with the content of this patch, but in case you need to send a
v4 please make this the first patch of the series.

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

