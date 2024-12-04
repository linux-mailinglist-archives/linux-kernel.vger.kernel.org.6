Return-Path: <linux-kernel+bounces-430927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640089E375B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C509BB27FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099BB2500D2;
	Wed,  4 Dec 2024 10:16:30 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBC1AC456
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307389; cv=none; b=UQTfvmkEQt2LV9IDlcnFUMB4BRMEMxeHDZSYUnfkdNMdcNKWaFzjJqj79MVm3bFvOCTbMN6sttUvetAs5EGoNoJccMdg4MK9MxbdGEYcuiQAocyjyVajhXpwLkunfR3I3gSYjMzm1XZ0KQFhuzUuQnO06Gb+JNEBugDWpcIeF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307389; c=relaxed/simple;
	bh=J83xAVX1wNgXoAthQnyhhlj+V2At6qbxXRE9HluNC1E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Xz3+w+SWgzhwKeoxjJOtkQOcN/26CF0e3SQzJuL7i1DibSqI1N0S0BT0l3r7TLqwca249J8X8aw+1et4k/1cqGooz5AfF/60HBj5WhWzzJaLaSL5f+Sd9sGbHFWrjGJchqrS+15rZHq0NhMEFJgrgYN440mYj9xkfGV1surwf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 397832BFA2A;
	Wed,  4 Dec 2024 11:16:24 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Uzn9N6zbpPUV; Wed,  4 Dec 2024 11:16:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D65F42E6140;
	Wed,  4 Dec 2024 11:16:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xc-aCKUjhrdj; Wed,  4 Dec 2024 11:16:23 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B78752BFA2A;
	Wed,  4 Dec 2024 11:16:23 +0100 (CET)
Date: Wed, 4 Dec 2024 11:16:23 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1562063374.32195797.1733307383533.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLhZZ1rs3Hhuwh2b3HLaqrAVUY7YwviQVUXgVi6XTZxnMw@mail.gmail.com>
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com> <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com> <87ldww4zrx.fsf@bootlin.com> <342000380.28770675.1733242094522.JavaMail.zimbra@nod.at> <CAOuPNLhZZ1rs3Hhuwh2b3HLaqrAVUY7YwviQVUXgVi6XTZxnMw@mail.gmail.com>
Subject: Re: Block based OTA update needs mtdblock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Topic: Block based OTA update needs mtdblock
Thread-Index: UB2+P/e388gS0Z+vHPLuyTSHrFuNnw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
>> >> Did anybody used block based OTA update NAND A/B system without using
>> >> mtd_block ?
>> >
>> > Not on my side, it is actually a good question. Richard, any ideas?
>>
>> What about using ubiupdatevol?
>>
> As I explained above, ubiupdatevol actually performs a full volume
> update, right ?
> I think the partial/incremental update is not possible with this. Once
> the update is triggered it should finish fully.
> But for OTA updates (Delta/Incremental), only the delta changes can
> also be applied.
> Please refer to this [1] about updates mechanism.
> [1] https://medium.com/@yigitpirildak/android-ota-update-mechanism-ecc8f6=
f69f71
> [2]
> https://source.android.com/docs/core/ota/tools#:~:text=3DAn%20incremental=
%20update%20is%20an,need%20to%20include%20unchanged%20files.
>=20
> On our NAND target we support OTA updates, including incremental ota upda=
tes.
> But without mtdblock the incremental OTA update (on A/B system) will not =
work.
> This is the main issue.
> For full updates on ubi volumes we are already using the
> "ubiupdatevol" mechanism.

Well, for dynamic volumes you can use the UBI_IOCEBCH ioctl to replace LEBs=
.
So, incremental updates are doable too.

Thanks,
//richard

