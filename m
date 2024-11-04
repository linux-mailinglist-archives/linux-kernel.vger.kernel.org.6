Return-Path: <linux-kernel+bounces-394425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B19BAEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DA11F20FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199318787D;
	Mon,  4 Nov 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="6mmp3G7A"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68817B4E1;
	Mon,  4 Nov 2024 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710824; cv=none; b=mRyushDMwRs/osNLNMr01T6igE48zzFoNncrUtJn1SZ+BZQsbHVeJOX5IQyp/GuoJA695Oq/fV+lhK9PxYoE/eoRBep9uxpDmYmYX6+1GIe6renWZD0dp3BlteE1DcAq82ITTmyI7XMRjIBCsRz1F0jxMMfpFdewGBxfWkMtqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710824; c=relaxed/simple;
	bh=ZXHiXGPAvmouGNCzwlTWatH7zxmlXNw+LAIkBSNOPTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A//qgQPPAKytmhCDaU03BPMBBTTC4rvin3GW/JUBCjR3VBoupdP/CEUpDCRE5ljOtOIDlXtbilCvXqFQrNdNUZXzy/MWEvcEN6J+A5fixA1bfmDgsbfV7RzNEdQy0YzBT9R0MRawd689rZ6zWJGV1T4ogBW10BUeU19s3TlzuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=6mmp3G7A; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OZ6ceByodZIjpBVVoFOulrOIVCJF0fRn/mN4p+R1OIk=; b=6mmp3G7AddpHNGQvxu97cUolBP
	Jwueqr2b7wFsdpMZ0rxgoAzjoLPblvRY0/L1JZyqd8AF+FXzslliatcFnI2P8469N3TijRuVS2qHA
	Fms3UX3MCzaPtQmXvft5eJrDTm8J8EueB1pPWxVPgEmM9T+bkSuRTICBFg22uVNFbS/W8fizfpAW9
	HvAGvxbpKJ0cqeFgYAwulvMg4/PNm+PI1f7ZVp8NDltV0jm2wAo27EgYTajrHmnRKSWjd7jPYssYN
	nphhNflkDTRl18Y79w8GDPcHam1Hp3+R1/zyLWRoHa5A0ueQNYvS/Z5+bYkilnP+cgPaUkjiIp5e8
	cEwuBeog==;
Date: Mon, 4 Nov 2024 10:00:19 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Rob Herring <robh@kernel.org>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mazziesaccount@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sre@kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
Message-ID: <20241104100019.1fbc38d8@akair>
In-Reply-To: <20241101192705.GA4062121-robh@kernel.org>
References: <20241029111112.33386-1-andreas@kemnade.info>
	<20241101192705.GA4062121-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Fri, 1 Nov 2024 14:27:05 -0500
schrieb Rob Herring <robh@kernel.org>:

> On Tue, Oct 29, 2024 at 12:11:12PM +0100, Andreas Kemnade wrote:
> > Apparently there was some confusion regarding milliohm vs. megaohm.
> > (m/M). Use microohms to be able to properly specify the charger
> > resistor like other drivers do. This is not used yet by mainline
> > code yet. Specify a current sense resistor in milliohms range
> > rathes then megaohms range in the examples.  
> 
> milliohms?
> 
hmm, do not understand what you are after: Milliohms range:
I mean a value well expressed in milliohm (like 10-50mohm) in the
examples, but we use microohms to specify it like we often to, having
room for some unexpected precision requirements as we do in other
places also (microvolts for values more in mV/V range)

> rathes?

ok, simple typo: rather

Regards,
Andreas

