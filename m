Return-Path: <linux-kernel+bounces-525571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8508A3F189
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1438422B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F42054F7;
	Fri, 21 Feb 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XhHkyLIj"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6D1F4299;
	Fri, 21 Feb 2025 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132681; cv=none; b=gGkdyBjVybRe98st0UrhIxaG5Aoo+pBtvD/bSxQC+bsKY/BLg79aW6syuPs+ndV5GMABbHgCxYlyipmLpuMSvRbHrCClyp9T8InZrD6ey4eCYzDymX1bV5KRhQ6/vhODf3y+nU9ud4xU33ngznIdQwkCNkSa55cEfX2lqsr97pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132681; c=relaxed/simple;
	bh=GDmCe53Y2cxCxTc2pZ7YEzEK4/9czcfUq1+QZdAFsTk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qw0rByUlUmCah9IrJvQ/VYZ8024yv1iGET4WpEVQd26vncWVopC4ILQYRg87SjTpzVxPWKUZ0TSiJYE6isTtTtSDHHyozBO62L7Be29enASbWFYb97gvP8EEcO47QJfDGtMc/VRUKZ2YdTw8N7kDG0G6Ypzzwsp/W4yIoHsZlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XhHkyLIj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740132670; x=1740737470; i=markus.elfring@web.de;
	bh=GDmCe53Y2cxCxTc2pZ7YEzEK4/9czcfUq1+QZdAFsTk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XhHkyLIjGTT7Il28wEPj+RRjv0JrC5f33PfZH262kEuNEMIz4hmlGpvw2W9HWFZF
	 /ndcPonxwDeZLXaEtwO04OIm1K8K2QFrCBEDx6ktho1ceQQpl8F6rv4uwJZgoplGS
	 zmu2pX+7XKGAFuXBqAEJeNXx3vtVVDCDzW9xWKcNeyQS07xQARbAe4wdkQSFlNQ46
	 UIpGlVl6cQBLRwmgwJIit5W6q5cyuly3w6A6T+dMekAcRPkRlZlPpvyY0FUbpaGj1
	 iXmBPUIqEd/m6sb+SyRvmnwL6jLlqDwq+dUsxxZ2YVyoeR1XE9Wy9wY6HL5KhRs9e
	 YzL+US2TPV1qDyMzhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1tC66r0bKZ-00bIp4; Fri, 21
 Feb 2025 11:11:10 +0100
Message-ID: <1fab8d2f-20e5-4e92-afb3-53167fecab54@web.de>
Date: Fri, 21 Feb 2025 11:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: More benefits from higher level structures for coccicheck scripts?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9LNEizQ2clxvfWWQdpZe1VFLV2jQrBCIvewuRxWmh8LctzB6RW3
 tQXBeNI/JAXr/5mX40qGXqU4JaMsM8ctXSNU12i3u87Mc3pM1LWRdPHwDjnpBLg/9GS2LtL
 O/x4j9kPphMGi7I4VlbspWlw9NF/HyLoCITfRdqo1WKmNrDQ9vU2xxThB25RvzcZOxEYJJ1
 nC2VEakr7sJy7dnzZgKRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DU4gnxnkiRo=;sXvtjMmjVszrThb0iCyBmFJUlQJ
 f06t+T3zG3C30VHEzr4Xc+B1PMcFH3/brZUB96xwqq5zMF9HZ7MaV0BBlPK3ijIWDs5Dl0pAM
 Zml5EXwiAm58uWb5Q1NKGJIBKnw4kTsu5TkoXzbZr8gOi98HV4wN3XFdR7z/TeDGBlUVlw6L9
 S8CIy/gOfGvXjS7lwuNcxKoE2b60zI08bu7JOwMQeJVneShdOBi08P2/XavFmOsUfGwkswR8S
 EqPKGNF9QEFSfBd4EoGbKkGzD9LTvKOoZbxJpH2rSrRYhg/W/bEcJDq1uBVSPQ1/Egk9E5Fw5
 CsZkNkn44F1fiBu48BptEaJcvIXgsf22t1FvHNc0VB7vvUUtau1CL7PjvtOYmwx9oRp2C1+7f
 kTFw1P9uoHItjhnTI/t5T7J4t2PXedLlqKNESrPZfnlP6glUmGBbEUjxv502ZXUFvgSpjn/T2
 8s3BnyHMs6q6vOf5b8znJ43xbvxsR/8+hYqYRX9KQQhn4rIkSSnelZHit1Ih6g5IGpv15a/c0
 EN5fXVKzo0B4T7j82LpKJMXv9keTba78b3jvgUpm0Y55HCEz2ItxWW7ByZHn9tGbpn9+tZin7
 m71uES0s0GhYMRdUaaVr+3iJliUjPW48E+eNSs3xErytatz4Hh//zcEkksBvucKP9bpO59d93
 Pf8POMr2Wi6VxQj9IqLBV4+634lOJxab5JPvlHm7S9TdBW/fvJS2qaabhxOJXkmLs/OEwG8hj
 w3P4EqYzOo3sACbBQEsxPxpkr5K9yOjNxK0k+34oi7ibmF3ejJKboOPTGFJM/nF2Ek07QTfEw
 V1SkXdXfyIi96TK3fdCzn0cNqiWoPpgo0MymBpBUg671NZjK5PEZ3oolxNUuZJYOwJzMlFcwY
 oAVBPEvhqBoYPkUSfwWVoDP6t8kS0tD3UskKsupIdbN+odcon3wzdFQ4AfWm2FHZO9nzPAGGQ
 TrbVmAJ7QhcCtbR9nFbNk4XvC4V0b4PS1q10wJCfWr41W72cSN4YpQbDWnpLl5ptGMYrtJBKM
 nXgj74Vv4DG7AobpCqPjQJYxRlAEuM3xrQydl+fvHl6Um+uquGBQzp7dZd2rqLPNgC1crJXE1
 viulVomotiDKkXMjQHWewVxNbPNXmGwEAAtyQRHZR7lni9tVsf75yaQ+gIyz7kWzduC6qfhQj
 Lnux/aCp+4mbK9SIpgWoNrxy0gwpdr6byC/q4yGUAzuryXj8RIkrO84QU3tkkLfWulRVxwDnq
 1qegcpgt8lG1msOXhNC4PeWd95EDa5NrSUQ0ClHgN6UC2ab1pTfWAK3enF+xfqWRJkslA4+BW
 Ib3DzToyp0gxu1p/JqOOeo5yyGu2Yv4PL1Z5SU7u0xowCQ3lTD5nwP8xQszgxeYC1FTyWAIvo
 mqZ+cbsxD5T6sM58ySjX+c+WQ4jiJPDWTdfJKzCHxpOMHhBqUCg1ejN/L0eWyc/6aX84DyT7f
 vxsAHTLjU2bMfWc5jH4R0iEOVQfs=

Hello,

Various source code was assigned to functions (or function-like macros).
Common functionality is stored at selected places.
Thus there is a desire to increase the corresponding usage.

Some scripts were constructed also according to the means of the semantic
patch language.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.14-rc3#n71

It can be seen that some of these SmPL scripts share also program structures.

* Operation modes need to be determined.

* Special source code items should be detected somehow.

* Data output should be provided.



Would you be looking for the support of higher level structures for
coccicheck scripts?

Is there a need for placeholders (or variables) which could be filled from
other advanced information sources so that selected data processing
will eventually not be mapped to separate SmPL script files to achieve more
desirable transformations?

Regards,
Markus

