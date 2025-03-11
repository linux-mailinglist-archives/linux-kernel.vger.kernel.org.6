Return-Path: <linux-kernel+bounces-556846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0D1A5CF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC13AE6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACDC263C9B;
	Tue, 11 Mar 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjXiFobV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46E1E47C9;
	Tue, 11 Mar 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721419; cv=none; b=fiUuKrTGjfftOGvNvtMenvdGLiDboXDGm8udk6k+vzuBNpuZS+59+8XbsDmvDN/tMRSj6GgoR3FfvwDPvwEDhumCFrGJG4rd5rQl0QsuFblVXHnfcvNWgmkeCtkpV4xZFBS1+E6r6YNP+PA/2l92quAi396PSoKbSkDKOmyQ+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721419; c=relaxed/simple;
	bh=3S+4LpN7e7b3uZJfj1/E1QA354tpygy85q1MowEoWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHPZIjcHinfuN92543IQCpkeQG/s4MAy+pW+QBI9RWq72vSEFNG50l89Jof7U8Oo/xfjoW6C0gTp/lHA5hxB6ZbItsNnE+YnhS7C52hPUGYDZ94TClDAJzp4dDIb/gvVvjlHrqZoyYuJZskKQNBvPIfxgepwdk6oyZz8s9eOfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjXiFobV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E0C4CEE9;
	Tue, 11 Mar 2025 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721418;
	bh=3S+4LpN7e7b3uZJfj1/E1QA354tpygy85q1MowEoWK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjXiFobVMTTSDVt0smcHIZTaw5+NmUk0LtIwKkkcGwNOcWt+j8cogMEfFrCDGP7CH
	 RcuAMniMwc37BgtVwZVMUfk5GVOceJ1VDa/aGNNiaNfU/Tsgj8hCJOwUzvcwgSOQak
	 yvc7yY0rWnWGu9UYpZzY7tDo9wF+mtCUqaGEPOxy1U1+TPwPo7NTTZubzvkAoPoS7M
	 8vWVS2iEGYyYzAe6BJZswI9tqVWKa7a+jFCvJt7l9PGxxUczQTrqWGw8LEu1bczfC7
	 DNi5Z9HjesAw26IG/FEkiDODCJVBrHAEPHGyG+PD7HTcHDVDDrZ54IOZsqOOEAKO7T
	 +DPzht/EdUv9Q==
Date: Tue, 11 Mar 2025 14:30:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: linux-amlogic@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] ASoC: dt-bindings: meson: axg-tdm-formatters:
 claim support of A1 SoC family
Message-ID: <174172141671.4180325.1225905170416898844.robh@kernel.org>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
 <20250309182127.1322890-5-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309182127.1322890-5-jan.dakinevich@salutedevices.com>


On Sun, 09 Mar 2025 21:21:25 +0300, Jan Dakinevich wrote:
> Add "amlogic,a1-tdmout" and "amlogic,a1-tdmin" compatible string aliases
> to "amlogic,sm1-tdmout" and "amlogic,sm1-tdmin" respectevely.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../sound/amlogic,axg-tdm-formatters.yaml     | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


