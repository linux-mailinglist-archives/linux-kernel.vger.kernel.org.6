Return-Path: <linux-kernel+bounces-183633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D448C9BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AA1F225B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AA53390;
	Mon, 20 May 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KmOC9yKG"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450E47F7A;
	Mon, 20 May 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202631; cv=none; b=YVjer0j8eU5XrT5Jds0kyT5vUQqrc8MVQQuLyWEgUzFK3cAk572UoLscVtZKtMoC6ktLxaw37NKUSPHCIM9MnRP0qt0yNZF+A+LAiJHzCn2l8TGTEymH3buplAmuh/8bZP2P6WbPSFvI91vPxM5I5kdFstkhY87dxMWpw2Nv5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202631; c=relaxed/simple;
	bh=BQNqP06GSDVu9Tj7mjQBhg/YiCoC2CZpovKQ8iNqmMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG4nX8GcbJ0Jh13MuvQbk5lC/7Bds69SuSx3evHer8jtsnCIVsD/KSlgHUdSCq3kcUfJfRXhmsuve+vduo6TXosjisNHqOw+ChpAfJKhQfH2m7tVawJt7RdaWLrwb5eHxQ3wU0q97OKs0Ct3uG8WB28x2QvmeoVJKOlRPI7XrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KmOC9yKG; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716202605; x=1716807405; i=markus.elfring@web.de;
	bh=H/QNGg2nPKB3k0BAOpxM+Ifc86MNlXrZFK5zBs5qBoo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KmOC9yKGBhzvYELm1tRODItKY5//687PzHHqxOKX6hjZ6u3g0ZB6srKQCBmbdQUQ
	 QzeqRO/M2FrNrvn0B0FEfUkQFla8jDb7EePmcj3W3OaYZclssz5EKGTVhcuUntY8N
	 VJAzlhSScB2zz2AgkXHa2ikC18Lfx3ScmQYPCUG828w7zzEOKHqaYi2RyNoZ9qpca
	 S3l1J9Ldkmglj2I8Q47+CyI03BLbXJiiSRT9fwTnC4CkkoI3Ez4+qHzsSsRHfO8YM
	 dzw//1B7vjbvkRdzK5cnUMJyvMoyDhKY0HHSBUv+GQc6I3QzTk+PjrzlMY4mZ5Jp/
	 3Tr5xkGi/vmVfjIYAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5lnT-1say2A02jD-00z0Rl; Mon, 20
 May 2024 12:56:45 +0200
Message-ID: <d73fe99b-dea3-4792-aa1c-c3317f296003@web.de>
Date: Mon, 20 May 2024 12:56:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dan Carpenter <error27@gmail.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
 <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
 <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pfLN6CMvnUjrP+O0uWbfRLmfnDfUkusv7tZFMmo22vPJY1J2G+F
 yramd7VFmb14bsvzhEhgLcesiEW2PiIA9B6mM+yPY6QTa6+MuH86oUHoJ2rzHeIsJegYiJC
 RWH9Utq0BrO/lr5AapGNAADaVcjwY4kMbtc5TIaSNTfDrL4+7KFWmpXdgR0xtmuIZRF5ojP
 QgEb8eoO7hG4kxxmGTerw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C0KQzvZ1nKk=;nia2MjUjZuwUDmG5dg9TwFSygQ+
 wsoSr1YEPEENN3zJTOQnY7vHSWMeIHUICr1tVqUCWLvIdZ9uBy6rVNrEn0cUc/92tYMn09mHn
 dkei85Gy5d6zRSDbt4P53PSeCFndBTyf7XTf87TpwPIM9PGyJc7hpmGfXdB2L2GmS/rd5Yfh9
 AMqWtmo51RMpNFRgKdC63p855fjAjdk1PPwzVP8nLdvlbGUat22S3qpFqy3UUg3oNeEotdMZx
 QCVo3blGgODPvizq0y9czegjRqX/9bMWA3+NKcfdJYgknSASgW3LqyMzY/IgS0Tk8YUq6MqEW
 s1ia1Kzw+cdNBO06S73CsRJnw13mFv5/QFEZ3eqrP4jjD9qdDt8isWS3VqHJ9tKVYpnOhIZTL
 BaVaKLUnYv2xx0DNKP+9dmIERoWzicsHMQgJWDVckx80DSg5qoGl/l5fghUExOtacKt9S3Cda
 HLATBY9P6TdbJ3E+th4dKuv8zCpsGnwS01kg27WuMxugO/4GcKPSakzHMO4+5eWCQShvgEkud
 /7MH/KJU6EzRyMF0x7TtEyO0aETkjS7oPVwHXwxyXDJVbddE+BQ6nmp1PS/yk/nS/iDRvxHnj
 Poxo2Ox5uIczpLNJ3EiJNdWIPHsj2Ob4PYYTNZUIc7KPd2oqFVo7JSqi9hAdG574I7I2fX+c6
 xE2gLyrnoMijMqIgumkeOVX1KQ9EGJtjbtoj9eQ5aqTwydyzDxgyrBvOvrRvruf9uCDkc31n/
 K9dVcUqYdqzfUw6Ys3TnuaFxzpzemgg+r8ibM8fq1tMlC1W2DZ1/aGYjNzL5SbR/HfUcrREMS
 OAZcTL9tUJPUMwdBjaUHGZBizgiB9uSdpDLCHJsOK/0nE=

>> =E2=80=A6
>>> Fix this by reordering the kfree() post the dereference.
>>
>> Would a wording approach (like the following) be a bit nicer?
>>
>>    Move a kfree() call behind an assignment statement in the affected i=
f branch.
>
> No, the suggested wording would make it less precise ("post the
> dereference" -> "behind an assignment") and also tries to tell pointless
> things about the location in the codei that is visible in the patch itse=
lf.

Would you eventually like another wording variant a bit more?

    Thus move a kfree() call behind a dereference of an invalid pointer.


Regards,
Markus

