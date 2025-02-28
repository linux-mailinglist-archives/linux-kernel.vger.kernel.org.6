Return-Path: <linux-kernel+bounces-539426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F505A4A41F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD08E887670
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2323F37C;
	Fri, 28 Feb 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEKk3fjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2872323F36E;
	Fri, 28 Feb 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773816; cv=none; b=Wpv0v0KwQU7mSJhWro3B54TWWQmivCOkt/KZ+ihIY4OzgzUowARkB4CEnZqwSXxgJldhdQvt7FFphm90mQw25qDWDzyTdMaRtzTkjf7HIG1Dpz8uq/uxOC6JkBtk70tDn50Hv4BRE4z/IfW3rb3W34k8Dgl77DLr/E5Yevi/a/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773816; c=relaxed/simple;
	bh=8TFtmmo8Cj/1mL9CXXBf+fIuueDZSkXfv+2WvtbbpDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsElsR49YKgCfeHJqSEzvyaNT3fdMG8ZjTVCu13r67H82rx+JXyvRFkQCTwy9ZDAWZfF2Z/hWJOgtxdkjE+4U+lPrSm6KBdn4fpjt0Q6UVvJz29UQpXevVFkZ2lvI71rdXUHC3tUJzZfknICT8RxkfrQ5jBAT8uJfbxBAERDMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEKk3fjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55366C4CED6;
	Fri, 28 Feb 2025 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773815;
	bh=8TFtmmo8Cj/1mL9CXXBf+fIuueDZSkXfv+2WvtbbpDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEKk3fjwrOLQ2ZdEJn6sLVv2phon3voA3UhAbVtZ0MzIS79r0ke/YsbpLpEr+Lunw
	 a56B0uXYVEtxmwwB3CqG7XPJPAYJ0AoQL5fUGVMUoGwrISCk1dO81Mr1Eah8RwsN8N
	 p0VGImGK3qlmR5ohnOhO3zUKv0fiBvwg07mUlSrao97lLbGnx3d/7L8+arvyRTlJxg
	 MYcc1ZQeyFxi7ZDvM1CIma2iy/Lt6Gv8YRSDyax5DOa7TQqM/v4czDzbSXDo3sHjgn
	 9wBVeNPdHwNQEncrPoUig4EUSNgRDfAV+qI0iNiYFFkapQd0auNrxBTCKLv99Wkz1T
	 wHT8S78eQTqXA==
Date: Fri, 28 Feb 2025 14:16:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, heiko@sntech.de,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 05/15] dt-bindings: gpu: Add rockchip,rk3562-mali
 compatible
Message-ID: <174077381343.3590059.11657408912105758197.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-6-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-6-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:03 +0800, Kever Yang wrote:
> The Rockchip RK3562 GPU is ARM Mali-G52, use the same driver with
> "arm,mali-bifrost". Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-mali", "arm,mali-bifrost";
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - Update the commit message,
> - remove the change for clock maxItems
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


