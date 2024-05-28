Return-Path: <linux-kernel+bounces-192498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C978D1E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6CD1F2339D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1B16F82C;
	Tue, 28 May 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CZE5zEbF"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A316F836
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905412; cv=none; b=JW4W8jMiresbob0bQuZhrDGNATEb/AKFEtb5hq4n7JXlcLJWmZmZEwQwUU+g28ee3gX/cx+FCH4joLV6vs2Fe+0OGgWdD8vdyMk3exnFM/ZF3IxGXLH1XgDNJuqtT9JWlpS6cRfKzjvL85uviKgIDE2O9XV4zYcCtvbBu+604Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905412; c=relaxed/simple;
	bh=wYKyHwOcRbmBl6fi/PN4M7/WvM7jsc6gP0DuKcneGNY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tWee6vDKuuW7jUvbillutu6lQcocA+VkyQ0vUvUUbwzt60E1estHD7nW1W5H5xwRGvz55ACyqZG5LwM/66n08oORdp9vdlENck2sulyhJ42SVZL9Uy8GQmlngX8s2fH8/o1ScwLN7jLsEk2WAh/9u5CG/g8DLe0UNn3MVTCYDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CZE5zEbF; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716905381; x=1717510181; i=markus.elfring@web.de;
	bh=x3mRV9ZWaP3e1MlgUeuaRbk+mdm99fVFI5oThwwKG/Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CZE5zEbF98SWM+qTHSQPtWlKxigEsB3P9HUEEaqgfqDvMnpQB8uFQTzhrtAKuxWq
	 YcKtzzYEojdFfyClJNY1QIrPoyFP7KoT8A+iuXDWr+8f9q84kBI2x+tyiZVuOU1zY
	 gjHLcts5F9+Yy8SHrY2b/xVl3MH2T8bB7zfBCiMx0RJWWhFE7zICNZWym1A9slj00
	 L8L8voNCjpiPuJNnJt2+8fp+RXkp5s1EGpa96ZkA0r1mt/pgABirR6PGgrXYacuPG
	 kI8/sUFHYhblfgR0Tw4qHp3c6jVLzfe7Qwa12nKMKNagjShTlCkI5AOi7ttWv3OBB
	 h2yExkBB0sw12fwjEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1s6kSY0Wu7-00DU2n; Tue, 28
 May 2024 16:09:41 +0200
Message-ID: <bcf08289-58a2-47d1-8080-6105dafb7929@web.de>
Date: Tue, 28 May 2024 16:09:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kunyu@nfschina.com, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Li zeming <zeming@nfschina.com>
References: <20240528064532.42532-1-kunyu@nfschina.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_sched=3A_core=3A_Remove_unnecessary_?=
 =?UTF-8?B?4oCYTlVMTOKAmSB2YWx1ZXMgZnJvbSBwZW5kaW5n?=
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240528064532.42532-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f3Wio4BrB6q2Ptyi59fTYK6zKvM0GX4FV9IUuw88nPOmzXlSzEi
 qvclbdyAFRNuOZcGeVENdlstnYrlNG10i5YdzYk0cMEwTJeJrKqe4hL/EJHMqSXnq6igqKb
 PGRTvdYUOwo/OONhUmZM1XSd3SboaPjBXcrc9JBwNf2VY3i0jo5IQBQSuFhE0ofnMYwRRsG
 n35pMh99JqJ4iaxnW4IxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uM4l5juRmsY=;3Wp6zio5SgowleLMICyscfjjFvF
 L8obBJ9EgrRh4fiBaEDGhnmdgyCPWTI6vKZFh6U+EWru1dINu1h58tBreSoNkTxsZMZlBhgJN
 9I6h7hl/ycEwRzbU2XBp5I5Of+iPGzNiqONaxRUOdRRLGyeVv4dLT5Nd8cU3LyXqfWn+uES06
 2scd9u4f1DQ/4lXI7Gy+rBqlL1b/kQ0sESDNFgvaso7/lwOM/xRLuWQp37BECFOzcOZCXNXqx
 BIGt8+noL17Cn6HedaX0WeawPfPNLCrDZxYwyfuDj3qhIx/AaWFNbd3vUx0CRRd4a1LTlycN4
 aEUwK/darjAP0hGhKiNUYUjzdlSIxSkqWbKxUXCfBYoGTL9ylDQPvOPMs0u2cCPLvxjtbqa4P
 bWDZkCwnIdGpP+65FRvoh8xfWVq5HpUVH+4Xu4yz17vBkX0Ay2vJEkkhJiIuNJk0Blm4ocI30
 MOLJYJVhjGZmiga/jiGtjMmSedEKk0DrqlOiHF2BtD2n4FCHTufT5jZQfHoEJ2e4vwQCWs6yG
 t/dDbXdZQIpWNjNAdFpU+cwlSUz2c4gursokmkrLxdLvkMbVFIGYd7Ktd2vwp0Y7z+QgzrYfO
 57lIEZJKQ6MrTSLAC+rGrNvQglFZl9Qe8H+Yaj7VoOKJoufx9DHTwCmLAANHgS/9pDyhz5zlX
 avyQUCIi8ZDqgCE0C7KP6KgfL2Ze3Rc1UlGSKDiy8uEZLRBX8kxOMjxObSwdFCKC8wbR8w/Yy
 ZGucy+TmzJesrYI4aar6tw+Wib0O6bIdolXEkg9fyjLYGGeauRHq3K+pzy1JpWbtpDf6RoigO
 1FMEkq8p69Fzc7BWEKj0mBwl5ZR/Po3fbjGeTviUiI4rk=

> pending is assigned first, so it does not need to initialize the
> assignment.

Would a wording approach (like the following) be a bit nicer?

  The variable =E2=80=9Cpending=E2=80=9D will eventually be set to an appr=
opriate pointer
  a bit later. Thus omit the explicit initialisation at the beginning.


> Signed-off-by: kunyu <kunyu@nfschina.com>

Can the Developer's Certificate of Origin become clearer another bit?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc1#n438


How do you think about to use the summary phrase
=E2=80=9CDelete an unnecessary initialisation in affine_move_task()=E2=80=
=9D?

Regards,
Markus

