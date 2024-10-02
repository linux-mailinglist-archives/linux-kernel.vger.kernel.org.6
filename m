Return-Path: <linux-kernel+bounces-347179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74698CF20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE407285B93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD7196446;
	Wed,  2 Oct 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/Zgjf5R"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E7194AFE;
	Wed,  2 Oct 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858643; cv=none; b=rEi8muBDsBKVFFrtLHuTZ4oqWSYSpMAx7q0QcM+tWqVJXf0YCG+6tH6qVx7m5CPJbZoF+h/ykPqoKegAzidBHoRUbjIeFG20ZiT7IWazlzi7UoJUU2SaasDmSH3DRJ1TnyM3BoY/5CGX4jpi3qkaPofKmP4Aqk5n0awwgohFWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858643; c=relaxed/simple;
	bh=sDpyKiU8Qfa6DrTGwTNk2wW672bu/eZPkI3C8jHVb88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQ8/4NZZENN4XRls9ubWEJhBQbuzN4nXA1Kv1Q7z4GU3tjzG7Hi0lH9me8muaFnN7KEfVcSzxFoNYNcQ/+Ep6fcLXguzORnPlQpTNiQqFFVJaZVisecrHkCf7rCspw4DrWF+UhZz7erCTGv4ucciR3N3jS2OBJo4pAbUBqYwwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f/Zgjf5R; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lhqO2EAoh9srUVDLjcw/2nKmOK9gCG7XO5Nvej37gPw=; b=f/Zgjf5RnTOySPu5gxxSei8x9b
	xuX7HGMpFydbwLHelO2M/qiYIGMPiWn1f7jdW7axVPcemAN2v9vWFssRMdgqqWT3Rxp6ptm4s22ne
	CHY9HAIy67cFZ4VTwmEJ79yL0ypI2pzjRErLeYNQggIu8YBnGfnUKnxtEJoODdW8wIy7BfOtgiopo
	+CBZWVl1Bla6x4g4jp+MFcaCiCj3TT7TqB/wMEt03Sv6jGmeOwGrnMnmLcIDkQZRwotKGlsJvtB9X
	uV0c6ME/b/75zUpfTnKQdTPwgX1nxKs1R2fpzJifzOzc1z81hzKSYnKypvrAXcR2m5YDkObdxJ2up
	/6cKj0Kg==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svuxj-00000003Rxb-2GVV;
	Wed, 02 Oct 2024 08:44:00 +0000
Message-ID: <691d9583-708e-4c7f-9b6f-664c069f9acb@infradead.org>
Date: Wed, 2 Oct 2024 17:43:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/35] powerpc/ps3: Reorganize kerneldoc parameter names
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-12-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240930112121.95324-12-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/24 20:20, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/powerpc/platforms/ps3/interrupt.c  |    2 +-
>  arch/powerpc/platforms/ps3/repository.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Looks good. Thanks for your fixes.

Acked-by: Geoff Levand <geoff@infradead.org>


