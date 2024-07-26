Return-Path: <linux-kernel+bounces-263009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656793CFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546981C220CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26881176FBB;
	Fri, 26 Jul 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laNhUgog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAED77F11;
	Fri, 26 Jul 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983445; cv=none; b=gx/p8LNvPLaB218f+uni8UrtXlgUyslSqkjPcpFxiigX4P4BgJ5WW4/KJD+EuV2larCSr3pi3JPBkSgkJQeYA/TLlCUebpujxfadva0OFAiHSAeB7okIi4UXoWvha3eKkrHEfQCt1k5W09U/gtTulMUsop9S3+rTmG8Nyv34F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983445; c=relaxed/simple;
	bh=eejb5Z2iHiQafBsqMRmDNsCTSs9ds9yQSnrjZYsNM6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MR6WASgPg3DxhT+S9y+2BlmiGTb3dn577ZHR8PHxoUFLR9bnAAPL2gIF66q5kGxSg+4WfGdl343VhzTUkkpJ9ZAmNlsvMxuUMq4Y6cWUq3iAR3Kq5KCPISFcRCYR/VWZSliU3rXKuwsP1x7ZjA1M2uyPtD9OYCGxDob0TfBAdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laNhUgog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850DEC32782;
	Fri, 26 Jul 2024 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721983444;
	bh=eejb5Z2iHiQafBsqMRmDNsCTSs9ds9yQSnrjZYsNM6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=laNhUgog5zdxQOChAauSSYv6EbLXiS4tVNsuzMZoKntWseRpNRns7yptfpQ3U1TRd
	 MPykf72StMZBxhF3WPEjdEjZb9LuJ4pValMuRcwPPK/fvS/p0xBLenLjEPmnIVWU3S
	 4nxGhc2kaV9a6iIo9DYT1TEPtVrdkmlmsWvLM3PilRHF0eISyJKz5aCHHB3YoJUFSb
	 9/BwkBK1id8Bl0Z+1HjbWoab10uaXaDKrJhWCXPo+sK47opZY0eT+gLcUNnsbZXod1
	 fqUbwjNmLWxm7uckQSTjQ5kkDTH0TvwQ4ocueSiLDYfYMrn7Trlo5Wy8rJsFxlo2eV
	 F1r7eSf2CXeJA==
Message-ID: <68a75949-a908-4416-bb2c-ad07596f0d29@kernel.org>
Date: Fri, 26 Jul 2024 10:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/tiny: Add driver for Sharp Memory LCD
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: mehdi.djait@bootlin.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240725004734.644986-3-lanzano.alex@gmail.com>
 <0f98db88-71d4-43a6-85f7-a9661c50a382@kernel.org>
 <j5laj5fy4lamyhlyelaq5vfu5vfxj4ybrssrbvrbyndbnvmsyh@6voevw6f3xf7>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <j5laj5fy4lamyhlyelaq5vfu5vfxj4ybrssrbvrbyndbnvmsyh@6voevw6f3xf7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 03:25, Alex Lanzano wrote:
> On Thu, Jul 25, 2024 at 08:08:57AM GMT, Krzysztof Kozlowski wrote:
>> On 25/07/2024 02:47, Alex Lanzano wrote:
>>> +static const struct spi_device_id sharp_memory_ids[] = {
>>> +	{"ls010b7dh04", LS010B7DH04},
>>> +	{"ls011b7dh03", LS011B7DH03},
>>> +	{"ls012b7dd01", LS012B7DD01},
>>> +	{"ls013b7dh03", LS013B7DH03},
>>> +	{"ls013b7dh05", LS013B7DH05},
>>> +	{"ls018b7dh02", LS018B7DH02},
>>> +	{"ls027b7dh01", LS027B7DH01},
>>> +	{"ls027b7dh01a", LS027B7DH01A},
>>> +	{"ls032b7dd02", LS032B7DD02},
>>> +	{"ls044q7dh01", LS044Q7DH01},
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
>>> +
>>> +static const struct of_device_id sharp_memory_of_match[] = {
>>> +	{.compatible = "sharp,ls010b7dh04"},
>>
>> Both ID tables should be in sync. See not-so-recent IIO discussions and
>> commits.
>>
>>> +	{.compatible = "sharp,ls011b7dh03"},
>>> +	{.compatible = "sharp,ls012b7dd01"},
>>> +	{.compatible = "sharp,ls013b7dh03"},
>>> +	{.compatible = "sharp,ls013b7dh05"},
>>> +	{.compatible = "sharp,ls018b7dh02"},
>>> +	{.compatible = "sharp,ls027b7dh01"},
>>> +	{.compatible = "sharp,ls027b7dh01a"},
>>> +	{.compatible = "sharp,ls032b7dd02"},
>>> +	{.compatible = "sharp,ls044q7dh01"},
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sharp_memory_of_match);
> 
> I'm having some trouble finding the discussions and commits you're referring to.
> When you say the tables should be in sync are you referring to the ordering of
> entries in the tables? Like at index x of both tables should define model y?

No, the match data.

62d3fb9dcc091ccdf25eb3b716e90e07e3ed861f

Best regards,
Krzysztof


