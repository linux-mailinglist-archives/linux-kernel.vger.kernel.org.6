Return-Path: <linux-kernel+bounces-560875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1829A60A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3142217FE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEC18950A;
	Fri, 14 Mar 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MvRrSmld"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54813C689;
	Fri, 14 Mar 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938753; cv=none; b=a4skJHM4x+4OkBSWZykU521ySDp2iqFFawQkqf6dj+jApdVa5j8H9Ma50Dc+UfzEjM08p2dtNoasJHO2VaXykkss/TwoMn7cxpejSCVeFE511CGvBGpu6GdtzkYfHoA49lUP41f+QwOo3LMo7+/NcHJ2llcXi8ETN6HG2bIxoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938753; c=relaxed/simple;
	bh=ErdAUNxFnl8a3q7R2K6I4y5BmQbu0eqLoFtEdY9r6Rs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YV4UqWSe8K8eytnrZAD9mCC1XY9kRxJNF6h572nB8Eew7NGShj2GsT8DYSVvAukiA8cRuWqefcgSqPQTQxVDG2K0ILhBPPJGbbtJopCNwSZiRvm0IDPGvn0PfbjOJ2P0ZMnRfnsXspi/JIr17/bGWrtOQUdT5c0gnaJz1mJFWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MvRrSmld; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741938747; x=1742543547; i=markus.elfring@web.de;
	bh=ErdAUNxFnl8a3q7R2K6I4y5BmQbu0eqLoFtEdY9r6Rs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MvRrSmldxccUSN8/HXP7Fq/Mas7tSNgniMmUE8NvG0S1JdwlPpRceLfgJjzTEZXP
	 uwKhuY37CYK2r5mnSOs9bZaqEMONAFwlX/1lvz4Ph2rTVHLPh/cPlFtFnzM22vtTn
	 AKTqyIDmZytYTLU2ToVvTjZfcnGqL0Io/LaJMuZx1gXBKuIpjLFChh6Sx4pD8L4le
	 7Z5GH4xg3Cj9Rc3FBFHXoueBnotJ5imNWWKK1H77KdWgwQvTq1WV9203S2yI8mhi6
	 ofGN1GrLlEVeHu91WGTR9QxvB4ZVL7hAWLZEV0OAfENk2ssqXEmCk344XHdIB257Y
	 z6UibC7QR72WGHhv0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.20]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1tAU9q04aP-00yacI; Fri, 14
 Mar 2025 08:52:27 +0100
Message-ID: <8f9fba3e-3b89-4e24-9b0e-d56d31ac6712@web.de>
Date: Fri, 14 Mar 2025 08:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] Keeping more higher level structures for efficient data
 processing?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BLEvzTlZ6bcuoj9VTygyG3sonrQpON87rJsJacYs/FFDYg8CHQf
 Nf6VOSvOEkjmah8pUul1bGafdO8mhQYPrCMM4QPs2bcr2JwVnA6iWPrYQFpdn9V9VfFiYU8
 ElfXdHh92PL0pJL3YTVltLMPVWbni6j34GwGXDlzCwy03+42nuV3YWcK5xuBdKW8aHbllzb
 AhWYWSUxcapIEOQVCg27w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rUiU2A3Owfo=;Mjebt+AD2WYiOeBMrgAPCkbvVA6
 A7kFQTGw8qbi3LhjXfljzFKXvjEh+wt4R/JazxbH9bgs+kPYUFicNqHTJCMEK180RlvsP85yi
 /OClHXFY1aPEJAfmQFebUR+RHVNXIOVN/LGKL0RMMk/gOvYqL7mwZgG2uUJrXN/m+uM+7eLcV
 KsrM1EphVc0YjZg1C4shIA6/0bl1lIE2QqiBUgX6CNXN+x2NVrWgYrrbFBgEsEZthqa9I/zmJ
 VbIr/Yz1DMZi0dIQftiUYoIzClP7HUCvVg+U+6UsgMhMQxGNtcMCom7mu4WXhzDWNzzfbY6dD
 eqtCbsgItYBbITf1r32tMq31O9cpDmpRTFKsQiCvqRYyI7zMr5Zf2l/y5fveyzXic76AnuHPe
 z2K3+2CpAdmjBDlCNDwVDaMftCKbfqvadIsLRuUxEonJOEbAdJ2mL5Ui3olboEPBbUxLRJ+Hb
 hkseVrrO5mM0OkQ0iwYdn70IBoWkNa+N/Hhz8urI80HrSzUJDOK8iFmgzfAAtsTgBps5fOiok
 jnijOn3rA/bWdx9fBHGu4bWzebytl2O7yHW71u1BhwWUpebCWtOge0utavy8H36+ZiOVglVwu
 GxzsNxZJplbJ6zhjWZcvAhuK0rzJqFsWxv0NTw50gYEyReB350zr2bTk2qMHVpXOrygGXOguk
 hzQgSf296l0VUsAIsjq7Huhy+lqVzocxY3OkbrkmxgQnw7bqmltq4bUsZ/Oi0ofzIx0qUzNoM
 EejHcVYpdPfRVHjbO/ecAKwsTaMFTIuCyCAjmYwqtBAS/zc+1ZdteoO0U8wndRPjXd1SN+Iwj
 GU0vCTTXAcwjJpMbfGvuz+lOsQsYwL7q2OccLOPjllBNEKKNY7+Q/S4atEJg/JdghtPMx8Jj6
 SRFokAJJjUivBRILLQKhUJMe0IK8a1fX1rmuFFzMekeLzNmcfQQShIOVxGvuDprryYKjvZAeV
 O05fTsplUWL3ULVmp4VKBI2aPcaK2sFoKd36crhukv9W5Cd1034CzDAu3Ff7aJpt1QwWz4nVT
 5Eb5SObzhhuM8Mki9RSMzZ6mtoZJw1LyEAq+zR+aApnleFlmcl7kKEEN4ED1YHf/Lnspdghsg
 6yeBrg754iqSO22ODqcIrgra31bNmpUU5YMLObP6L7HehK+oTNuI6Eb2CkYiWPkG4Qvlddh2K
 P0RpKB7AVhiRUXLM1c4t7l4BREd+wL2Xodf6eE6nJ/0xRLS8LDwnAO+8dYt3u2SQO58xR6YLV
 zhjcBY3a6dV1VG+B909rB4G3i784E6PkxfGeLdPZBo5jb9wNM1wx5OLZftqaYtwINgHRrIfIv
 TxOOeC8nTokpM/jJT9WOzFIoQgVdV8IQnwgALXCSjpvAf8j2d0Tw+QgRG9GynDqaum8g+EdNe
 T4LH/KusVZvqbtSGAxkydl6GYUSiQBXqBepUvEV4YxsJBWSZQ8k8ArwizHvf4uBM1wG5OpuP5
 JCaaqrmh9DpF0L1UubNdDFSk/XSmyN7cmM9JwRMt6bAg4VzH9

Hello,

Well-known data processing approaches can depend on various input files.
The input files are usually transformed into higher level structures.
This data transformation needs some resources and efforts.
https://en.wikipedia.org/wiki/Parsing

You might be looking for ways to avoid the repetition of such resources and efforts.
I imagine that an information system can be constructed which would manage
corresponding higher level structures for a while.
How will circumstances evolve for further software evolution in such directions?

Regards,
Markus

