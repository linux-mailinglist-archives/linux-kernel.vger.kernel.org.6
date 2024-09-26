Return-Path: <linux-kernel+bounces-339821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF85D986AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F3283BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE5173346;
	Thu, 26 Sep 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItCKBw0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C781D5AAD;
	Thu, 26 Sep 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318245; cv=none; b=jUmWOMb84i+tuIykdZ/33iiH3OFgtkgh1wcWl/h37LE3UE5HjIREi20fisypFdZjzqf3N/O1dDL8rQXQRMFXAwhnu1VDSS2fj3EkPxKa2YbFzEhqXBs6kT3lvH3YAk2uNvvuToRUTyAxX4BkaL/rptPfoe5gnR0JztAqBt7d9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318245; c=relaxed/simple;
	bh=edexfdC/ocnB28x8YZycnn86ClnWvbkN3L22116f1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRQ8HfHjMezPKNn31PdK84iGteJkUOZMBo3zB4iZNhysbRY8VUmHjNP/bNyfZ10/8b3uLNp4Fcdo9TDB3NHNsckF9wRV8Aow8wp3wBwdC9bA/jNd5t3YQd1xOPiFEm9sWPNnK3lUKqZMl5e3Mb1UGDYBd3Wc5y5tH124v0ztiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItCKBw0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E4C4CEC3;
	Thu, 26 Sep 2024 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727318245;
	bh=edexfdC/ocnB28x8YZycnn86ClnWvbkN3L22116f1ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItCKBw0j0nTuMZ3ozUXKHTkBz3p1aNIkSq5eAF0sjA9Kqc1xfBHfi6aqzGtgT3Pe6
	 T7n5hm43ccXZxrqkqY8K71hxMOcAColyxPiDAteFKZA82hO8pcjJl2avxOW/miRhfi
	 0ttJFzyzXLoA/U6n+y6f04ct5JxobjUl5FnhNtyqnqsPCBftiRXr+/ltopDGa0FiWH
	 LEbRHhWPMWgkrvhDiIylqeXYKw3iHoaHzJSyizmMY1dEBRhYsttFXqQLr1DbApIMpH
	 SxHM/1OdXagcSHjFebKsTZoB5lBfHmqg65FTDNBsTXM56oj3MO+Fd/x7CPGSeGay4K
	 f7eW0Q3Qhz8Pw==
Date: Wed, 25 Sep 2024 21:37:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, prusovigor@gmail.com,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com, Philipp Zabel <p.zabel@pengutronix.de>,
	linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] ASoC: dt-bindings: Add NeoFidelity NTP8918
Message-ID: <172731824259.2419360.11848183145246502925.robh@kernel.org>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
 <20240925-ntp-amps-8918-8835-v3-3-e2459a8191a6@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-3-e2459a8191a6@salutedevices.com>


On Wed, 25 Sep 2024 17:52:41 +0300, Igor Prusov wrote:
> Add dt-bindings for NeoFidelity NTP8918 Amplifier
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  .../bindings/sound/neofidelity,ntp8918.yaml        | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


