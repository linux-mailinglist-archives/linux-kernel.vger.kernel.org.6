Return-Path: <linux-kernel+bounces-184108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077908CA2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87105281268
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7009E1384A9;
	Mon, 20 May 2024 19:24:18 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDD137C42
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233058; cv=none; b=u8HSp1+bJAxBpK/yV7kGtOIKwH3X4G7FHw09Ib9mlsHHj+poImnItBjRLL16r/qA0t77z83fejqjga8xlICEkqBasVd7bw7TULQvodUAP/V47bjP+I80nkNGB+jxdsTa8QJasXaA7w95ti1ASFFLOn2tWi9TzL2+M1hWt1GfvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233058; c=relaxed/simple;
	bh=G36Cx8GySjdHNtcYSHoIRZuKeuqegAU39EJK3W+NhBc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cku+1PxR3EbKLtpRRoDzUwc3eHcloKNtU9DDyjuaHsczS3EAQqSf3FCttMQbkTLgBX/E3mbADC6Co+M0jvsdJiMCOkvMbA57+vOT0SMobzWiGThoT/yyswqEcmQhQqN6QUQe9S+Cir4CiyfRO7S7fZtpmZ9l2yEeZHM37ZXyRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B8E96195FC2;
	Mon, 20 May 2024 21:24:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6z9Gs4OLXYbU; Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 678D96195FD7;
	Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cPpfmcUIF8d4; Mon, 20 May 2024 21:24:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 09C736195FC2;
	Mon, 20 May 2024 21:24:05 +0200 (CEST)
Date: Mon, 20 May 2024 21:24:05 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1300720405.125947.1716233045712.JavaMail.zimbra@nod.at>
In-Reply-To: <20240520152049.GB398@lst.de>
References: <20240505001508.255096-1-linux@treblig.org> <20240506070648.GA6506@lst.de> <ZktoVIG500he350_@gallifrey> <20240520152049.GB398@lst.de>
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Remove unused mutex 'ubd_mutex'
Thread-Index: sUO+fPwo/Hce3VfngHxEy05naTFOLg==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "Dr. David Alan Gilbert" <linux@treblig.org>
> CC: "hch" <hch@lst.de>, "richard" <richard@nod.at>, "linux-um" <linux-um@=
lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 20. Mai 2024 17:20:49
> Betreff: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'

> On Mon, May 20, 2024 at 03:12:20PM +0000, Dr. David Alan Gilbert wrote:
>> * Christoph Hellwig (hch@lst.de) wrote:
>> > Looks good:
>> >=20
>> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>>=20
>> Thanks Christoph; any ideas who might take this?
>=20
> Probably Richard who is alredy on Cc.

Yes, after the merge window.

Thanks,
//richard

