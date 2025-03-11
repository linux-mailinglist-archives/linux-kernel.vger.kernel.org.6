Return-Path: <linux-kernel+bounces-556911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673C6A5D084
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750FC7A3DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83201264A7D;
	Tue, 11 Mar 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9yJ5ktZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB107264A65;
	Tue, 11 Mar 2025 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723942; cv=none; b=U5K6oS3RIWOViSgEH1qVQiHyTu6cLb4xvOKqe2YmHXyEkLcpnj1RH582YDv/NqA/MIRMga6+DSVmR0+0sYLYxC8KUB+ioE+ejZ9mY7c/+4yE4bbNIlaDrygzrNNEm6+yKMwUTC+uOuoGpLiC+l8yEu1FNyrGf4p97yrx7SZ+RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723942; c=relaxed/simple;
	bh=hwyJyim9PZ18lgcGQ/3SEBR/IWw6q8eLGltjBZQCTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncbKh3QdQvbwIZsNKv3yBENcaR44ZkDXjepXqiTzqetoAElekmaSdKl3ix9NfcVOG8PkrElk+4hC+MyzjqirEY9yzKGVlimCok4GbJZd7yRafueQBwrycGZvg+dkyVn72jXvTBs8f8/80ywpQxqHK3inlyXetd9yLpaLx/bd8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9yJ5ktZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B1C4CEEF;
	Tue, 11 Mar 2025 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741723941;
	bh=hwyJyim9PZ18lgcGQ/3SEBR/IWw6q8eLGltjBZQCTF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9yJ5ktZ4eiLTqgwThzF4fTLnpb7IQWPT2bREztyjKs5HOPfGH1r1HTlEcKliZgkZ
	 kejUXX1wTmT9snigPtspL1oGSXoLltbRKBGZy2cOic1WTrT1VXj6DCzCxv8qj7/FfF
	 8ha/W9oFyzRgWQ6HoQAqS5VOqtlAuECoLDVxEfoNdnKQH+hBqXksl85PGX5DUr9Rgv
	 c3tapUX4cm5coH8FJ0MENqB1htMZFz9IJapMWLtpGjOH2AHXevGow3MXl8+GOFUOrz
	 wDqkbaJ7rqXzCdCVGWygR9k/m0SlHcJuPbMBXne1mSfhrOKlf0QqPgjRUihxl6ggdm
	 ddvYCKEnd24zg==
Date: Tue, 11 Mar 2025 15:12:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add POWERTIP
 PH128800T004-ZZA01 panel
Message-ID: <174172393994.51336.15963394687109008686.robh@kernel.org>
References: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
 <20250311-add-powertip-ph128800t004-v1-1-7f95e6984cea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-add-powertip-ph128800t004-v1-1-7f95e6984cea@bootlin.com>


On Tue, 11 Mar 2025 17:40:05 +0100, Antonin Godard wrote:
> Add POWERTIP PH128800T004-ZZA01 10.1" LCD-TFT LVDS panel compatible
> string.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


