Return-Path: <linux-kernel+bounces-566117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD1A67367
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EF47A21E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546C20B1EA;
	Tue, 18 Mar 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L7Wg0P2d"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50A1DD0C7;
	Tue, 18 Mar 2025 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299415; cv=none; b=hlCdc10lJoHVkAEck38rCvn9Ko6lncFZNaCLGKO2kw5cL7EbDZ+mp8+923w3vD85pLtgVgTz188ijHLPavkj2VgvGPeH9wUhErDQJaefvtd5vFL+xJL43HCyT2GQIn8riFPkKe110judfpny85t66qq9GDjxiNBicjvgByltDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299415; c=relaxed/simple;
	bh=ZmW+vLInL4TVw3R6aLHnH+2nNOzUGxFUKwW2uHXTgP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdfUIMqelFDNuCrIdyeQNdbXkQgN2COYRp9FIexYYgYgKUYjwVfc7vmn6ja/vGJ+YJIMgLqRSNX25VgB45nQpwXl8rYtHzIsZ2Q/1F/E54FAIebYEYLR+ov+wdlGx6++7Z2u879PSCHNo2YD9fJrdNlv8eGduL/81c+PhoIstZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L7Wg0P2d; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742299404; x=1742904204; i=markus.elfring@web.de;
	bh=ZmW+vLInL4TVw3R6aLHnH+2nNOzUGxFUKwW2uHXTgP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7Wg0P2djKNFAD+O3Q4ZHqvrvUPLNcIejMj0ZeqsYJMtm/Fc8us2LOJ7r015w35M
	 KdNfqQfvp1fTspYyTtwT+KP6RQA8rTLVJDtcfsJXEb8KR4on6ypnyvuw3rfBZQIrn
	 ZZFgkyqM469cpFP9dEzwK98LbWBvifBSnKiIwmA2lnppZZR7/cXKnT6GOjUjdnvvk
	 pkCpToHBCYWJlIiQ8QyBB0+LvXeZ0joFIr/aIQabV5b7Xfd6txQRelnrHqbHF8rXB
	 EHWu9pA7XAKt3s59KS22C/rDb0Sg0twPoTV3gjX409P9MdJM/1gypkelckwdCp6oQ
	 C9fZYMYJ5TknFGmV3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1tGn8P2vqb-00gpfH; Tue, 18
 Mar 2025 13:03:24 +0100
Message-ID: <bf19c4f4-5ed5-4210-b123-92f79d27d6e7@web.de>
Date: Tue, 18 Mar 2025 13:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mtd: cfi_cmdset_0001: Fix exception handling in
 cfi_intelext_setup()
To: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
 <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de> <87o6xyab2r.fsf@bootlin.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87o6xyab2r.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MPLm0VzdlVlkA1TXNIOswRWGxRtA2+1bMmklnR4aPrxPWMr3Kf1
 CZZtRDu4IfbAjT2N0xiw4T3bz4HqMQ9Kb4smmMzg8HfiFF+vpjS4qscsSbgrEL8hwb6sfu/
 GNL09pdf3gx4eH2m3b+TYvjv0Jhnhbse3LC0KyibcyQ3BezfHu9NpP0HYz5xAeb8TljbnTZ
 dStNLKYXTiPBMcwTjHnyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dgWHoFijdxI=;nNogpUYmWqfRtvqVrL3ZzCSY+ov
 fdNZHYsKx7QloW5WopqUncWZCZvpT64zD7g6jW4Rr8z3ezVgpwOtaykrijwjjs/TSwE5XMsge
 Cvqe8Qz8Vi7+13bQCTrIF3xo37KGM0sc6CuoN8/WPtd5XhaCUzwFJV+qCsUbGCM2sLsg1/ttI
 /9PdRALH7wc5aE9TLH6yow4kVFlXMbHSr9O506Pp+I8kBWH+2nXoGfDG1TTcKuCEjKhcog3cC
 L2C1S9QY7kKdnKdHjKD17wqAsX6V98H1sTTRyPwc7Zi1emq2Cm6ZDDedsGfaT8PqEL10WlVw/
 zgK/I2LoxPYdEW1yqkqb4JYD9iAVf+LOkSoLsS6pbsnnzw1nyp0wiU9IZeLwBpOkl1ZmOSBQm
 bQ3WzozxW001mj4+oemclwY5mmi/kUD4AKVorupai1zkbxpkDWwIG7ElTjTnfvB0pNKSoXEXR
 2vq+5zuWL4vsgLp2oFebCr1tL/DAaTsHjPZ82fPV4QHZBojI73b7xwOCejbdjcqd7stP7QdvK
 kSY6yeCJdKk4ZUiMovMCdZ0101qMil+U3nLynYWhj9VJesc3zrozrMJ/PaJLnUEConlAasujD
 9ySrN6rV9D8NlcTPUV4CGBaeG/7pSWsYSeqtXt3WRe8Gg//iqK7BuhCMttZEqR/upNn1aNNqC
 lurBqqbBO4f/CsqTZEi6ZFQd10OFRjXVPPvndFJPg0a3Gm6vEU7UB0WsGIpuPJWyo3jYcl69E
 P/aDcZjlTEZy6A7STh+jifGrtAgpkwLTzoyqKt4Ju5WPt6Wwksqn4SbtRe6QXK4KESczCDO4T
 VWJiIXmY6n2ixeDbySYfJvoBwJ//rH6PFSbwK9T18v8gIrqc6Z8zqY0oR1K/+PklJqd7YnMJO
 m0rgGd8EHhuaDd5LpXBQIeI22aqj5135lWv4cDLblgfklcJz8VpfRlr22aoVkuZb3tf/06U61
 gzqiXMFhL2MH45Zx+ey80HvbnAHnofRmPhSLt/fUoysIZr6Ndm3BXFko4RuTUNdR/X2CzQLRx
 wUAdw2A6XzteVSrwNjEoP9vv7nHUQWzPXtVi+Ff1YWXhGNihDFW3XB+5zlUOGZBIoJkdn0zNr
 wdaK8/qFzJxpGzemwDGnujRB0fw9jUFStSBtHwvLfSOpNrE4awVmsFzox1imb/lRqWJK+MYKG
 shV+ZeWCxWx/DbRLxIq6G6os754LOYwVXzslOSptOGwM3G4ro3cJWEG2ytxFCAjzHEYGqWfXk
 E4lzHqW6Hh07S/qzClpTqF9QTMIOoS1Dngq++zGHt6QNY965Q5W7Pt0aePyUrU22ILVYRcFZC
 +zhTTJ4bnGUHA8jC20Lq5qzU/8bQjb/lKVZQZCU0PyUeM4tv2czblXi82vRM3HAiHHHjfekJq
 8vGnhp/xZLv78SYmG3fseLT5zarvjZCWOmTm+pGTxlIzZHe3un4DZGnMXCE6Ty9ruBDuc2yqH
 RsvVU/Pkbhfz80C9ye8vVGzRzoFZzwKJqcIqKMiRToEzGBw+b

>> The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another point=
er check despite of
>> the detail in the implementation of the function =E2=80=9Ccfi_intelext_=
setup=E2=80=9D
>> that it was determined already that a corresponding variable contained
>> a null pointer because of a failed memory allocation.
>
> Can you please rephrase the commit log? It is super hard to understand.
Which wording variant would you find nicer for provided information?

* used jump targets

* null pointer assignments


Regards,
Markus

