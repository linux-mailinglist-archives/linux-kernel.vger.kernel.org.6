Return-Path: <linux-kernel+bounces-510119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66181A31864
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36CE1886499
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BE268FCE;
	Tue, 11 Feb 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxbbnJ/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3A267B10;
	Tue, 11 Feb 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311719; cv=none; b=UWTWBHFx2Ra+ZaAX0JgMxsIKETBmL/uRxxhdKPfPoeg3MrHYeL8kx1Fq3hHIMwKmHzW/f8Rba928gUBt4lY7j7ZDblBGBn67YWEddD45wN0oo3C8AxW3gDIR/Mbg8S2XnpNig+XYhiDxgHPIviv394swYq9SLPTRCYB6MxSoMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311719; c=relaxed/simple;
	bh=oIpGHDF8M2+c4Dsyg9+iglrMFMtxmvTwbPW2do/K2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmBbrj0CPz4YdCE9eLgI7H6V0yp7T2WOEr8TodbJwKvpH8LqJqgC8kjC7oiGst6cH5fFXXAAMc6EwBhFPLzSwyNroruG0GQv1773x9O3IBaGag8reBn/IAuk55Au+A0ASKJqP26PIFelTHRuy1rscpS0DWKgxpzcCtptGzeD1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxbbnJ/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC14DC4CEDD;
	Tue, 11 Feb 2025 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739311719;
	bh=oIpGHDF8M2+c4Dsyg9+iglrMFMtxmvTwbPW2do/K2ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxbbnJ/idaE5a2Xpeqq+FoWpl6UWts4gcQedeUrjQ0x9SKt+Z6TpUBDcUAhwEcmJj
	 TUw6lJTvknoMe/sZzJUOi0qxHSBvT5a6QAFhiala7MyZbsFSSkiHlG+uX5CX/mmVkC
	 jJQmj/WQsCXlRMb3JP6RCfXDqSChLGf8jBwCY51oDhz0OCZVACP8Jp/mr12Gv0FcIL
	 9lW/LTW0v4wsRPCujuhP8DLUC3KcfnXjf5RKDXINL7jSvfjl0KwDUr5N5OrKcjERfY
	 poy0zqpnj+xcVThDo3YHBqCPC8+U4+8tspePhjSoXa6FO9V2z4YzYOXJTVny8AOhoi
	 BlQWOKm4LHZ9Q==
Date: Tue, 11 Feb 2025 16:08:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	patches@opensource.cirrus.com, Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/5] of: Add of_property_read_u16_index
Message-ID: <173931171708.1269898.9940271359989638043.robh@kernel.org>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-2-francesco@dolcini.it>


On Thu, 06 Feb 2025 17:31:48 +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> There is an of_property_read_u32_index and of_property_read_u64_index.
> This patch adds a similar helper for u16.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/of/property.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/of.h    |  9 +++++++++
>  2 files changed, 42 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


