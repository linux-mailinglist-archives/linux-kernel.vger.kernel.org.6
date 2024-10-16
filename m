Return-Path: <linux-kernel+bounces-368597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824E9A11E3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD59BB220C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3421B4F2F;
	Wed, 16 Oct 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj0y9r4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182316E86F;
	Wed, 16 Oct 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104692; cv=none; b=t0T6kevo0ezRjZYNra+H2OLT8Sg49O+5e+/mNXKNQ1rXe7hVKUP2gGTZ0+TxXVYNrP5gc5m0XIpI3f7neJVQUN7LuBRLsWo7tT6ykwjJrnHmltcB112Qm8znu7h2sk4R2HbGBewki4CBhYlvSBBpF6Mqg3NLLZNCmj1XipPf/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104692; c=relaxed/simple;
	bh=MN1HRH02DeXpotThFBo9SNUk9jLPl86YgdWUzF8+UdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VMWhJxuyxgBw4rSRIgtWVthHXCfKKXBl5W8vBrPk7hzTaLNUZPgPq1ohD3FO4nk7hnQ0KWCwe3bMxT47PIKNaIZa1IK0jEMx0NfiFukDeB4Su99N8xtZk4PyFUIpro2Vn2AOeiI5V8fHvqbQ4SfbyO8f6uDTlQzgHz/d10ibWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj0y9r4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AABC4CEC5;
	Wed, 16 Oct 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729104692;
	bh=MN1HRH02DeXpotThFBo9SNUk9jLPl86YgdWUzF8+UdM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dj0y9r4pDeIkUGOWJ64wqYfCuLAi70so7iZDPHZPXs4FAzEVGvLG1u0AqeL6tkpJ7
	 GD8RJlJVXkec3HoAp8qvkTD3MkY6MmgoCmpOJ8HvP5WyfIL9jUhKQTOAzLvxEc2tv2
	 eITupwkCwS+/4RDHeYoNGAHZHxpOqBjfujmCGXLUt/PDQvQ1R0xyCPC8ZK/6b9rfIt
	 tjaB6B6mU/4nKa/wCD32yjZ0ias2pH4XIYywObTyKbIlq115ivut989q/SqDaph6mD
	 Pdsq44OgANCzKhmoqgGEp//k1Q09wZsAHF6U4Dv5rfmkLTrfeV+z4DMzHflTo1k6I5
	 kgRjSXOcHSRlA==
Message-ID: <800c377d-1ba4-4831-9c32-939d640e13dd@kernel.org>
Date: Wed, 16 Oct 2024 21:51:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] clk: twl: add TWL6030 support
To: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Lee Jones <lee@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
References: <20241014161109.2222-1-andreas@kemnade.info>
 <20241014161109.2222-4-andreas@kemnade.info>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241014161109.2222-4-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/10/2024 19:11, Andreas Kemnade wrote:
> The TWL6030 has similar clocks, so add support for it. Take care of the
> resource grouping handling needed.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

