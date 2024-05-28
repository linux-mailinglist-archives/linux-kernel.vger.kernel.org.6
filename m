Return-Path: <linux-kernel+bounces-192681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F038D2098
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAE72850B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5049917164D;
	Tue, 28 May 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ7ugF7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D340171063;
	Tue, 28 May 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910835; cv=none; b=RcBrin2oS41UxbdMj27P2EWDDlCTZkowRrXhm0Ofl/xHUBa1LJetZEKyYG0rvA88Aozd49rKJbqDQBptnBUip8QFZ/0hMs5gY9wOohYufPGpbFT7xd30MJ0nb2M83EWywpyM4QARbl+lTCgYOj0/UybySCx6AtkrVlyd1Dj4uHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910835; c=relaxed/simple;
	bh=+ka7lAt0AaEKQOhVhdJkYL8d3RJmgi15bjbIH1lkuVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J28CAhsWE/E0UjWzgyLG9EJwa18o7leIpKJIo1hHHEaINsauA5sE6JNNqCEMVz9h3juxQM1xYZD83j3qTus8B1qN+3dzstIQgUBcvaFDYVPhEFNybBl/eybRKVfxcW0i+JCBNoysS58V21BYo/EUM+WIEtzkBO2sYOO57KY/Zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ7ugF7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4197BC3277B;
	Tue, 28 May 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910835;
	bh=+ka7lAt0AaEKQOhVhdJkYL8d3RJmgi15bjbIH1lkuVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ7ugF7oci9zQMotueSFnxOlJdgSRiTo1pl+/I7Io2p/oLGt1ADaaVRU77uZxsPuH
	 rtTv+4iuxxOMr2QFWMz+5rPxQein+0RRcvFeJ6GQHxOdY8q69i0M51lcTVSE4BLsCQ
	 pXnxFVWjEU25VKXaxQSE4toPW/4jrKA/047xXTq9WfVvCi/aey5IGZiQCss5yDqNBt
	 jFH0Tt5U6Vmv/8bVtmcnFHzJApiGDaxCtxLX69rkaD775rLU458uIMahHRCr4meZ9S
	 zgLhUSYIy19b6eoSnA2k82xb2gcQd6LfbrY8S9iyDkpeIFSKLGvw+KRr1QSkTpUu5U
	 P7TIJXaOYZuBw==
Date: Tue, 28 May 2024 10:40:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
	krzysztof.kozlowski+dt@linaro.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
	shengjiu.wang@gmail.com, lgirdwood@gmail.com, tiwai@suse.com,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linuxppc-dev@lists.ozlabs.org, perex@perex.cz
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform
 support
Message-ID: <171691083154.676898.17539558632778396948.robh@kernel.org>
References: <1716347305-18457-1-git-send-email-shengjiu.wang@nxp.com>
 <1716347305-18457-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716347305-18457-2-git-send-email-shengjiu.wang@nxp.com>


On Wed, 22 May 2024 11:08:24 +0800, Shengjiu Wang wrote:
> There are two MQS instances on the i.MX95 platform.
> The definition of bit positions in the control register are
> different. In order to support these MQS modules, define
> two compatible strings to distinguish them.
> 
> As one instance is in the always-on domain, another is in the
> net controller domain, so the compatible strings are
> "fsl,imx95-aonmix-mqs", "fsl,imx95-netcmix-mqs".
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,mqs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


