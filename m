Return-Path: <linux-kernel+bounces-576609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A2A711CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C9C3BAD09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C6E1A0728;
	Wed, 26 Mar 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mii7FSDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0CE142E67;
	Wed, 26 Mar 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975971; cv=none; b=PSWbWkBsjkPCzhAMHYz6ZYIDP3uRwXZonvWVgq53+TULFBNweO3eQAFjWfiYi3bFFltyUONq+KdcDTx4HoluUV3ofwt0N1mwW9SQPLiteN+vqD4oZ9YIYLyd22UJcZ3vxn9j/00SUNU2k06FCiPtP/isPyxpXpOUX3HUySR+f0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975971; c=relaxed/simple;
	bh=GI0HQEGuZP8iCCZJg2AMr3qkP7ZGL5n1MxX6572zavY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2UI4OuvhvavDJ0VG6Pnr1QTMUGmDnEsGLGOUlrolpYRp7hn2kwsVrOiCLX+Cxu3C8EhmnmRmmVqenytmmHfBt2evhC7jTHzDcqIsS2RwLsHZ5/Qr1l+XwhfpS1DW15kZ4dz7NgM3GgsBaQJp3SCwWe2Fl1fRVrULpf3PjKEbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mii7FSDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE02C4CEE2;
	Wed, 26 Mar 2025 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742975970;
	bh=GI0HQEGuZP8iCCZJg2AMr3qkP7ZGL5n1MxX6572zavY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mii7FSDEvFTIAGrC0zIiB8VfHJ0LAz2AuvEB6RwVbZDHtcEvmv3k0ttHgz/3ZDgH9
	 MmZiI/HbumLEAUeKQWpPVH/EnqYeit9AxUYuN2d0DaCAKn0SpLAGm6lTffw6m5kyhn
	 lTPXuo+luSJM1lqdiVIoxyFORwBKXAWltA3XaDs0/iQts31mlWzW+lK2k3fkTeiMzG
	 bHC2I9xdZZhP3bXGV/vvZ2z90C15VvvyruQdTL0Iih5JxI5SgRmZMaU3F9Ox4V+4w3
	 BwooPt8PPOJBzBeLa2aIpIyf1On/i5cSZQc8fjJXEdWY1zNhaGvns+YBklFSJAq0mF
	 OzPng0TxkXGyw==
Date: Wed, 26 Mar 2025 08:59:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, hjc@rock-chips.com, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: display: rockchip,inno-hdmi:
 Document GRF for RK3036 HDMI
Message-ID: <20250326-poetic-happy-peacock-a79d29@krzk-bin>
References: <20250325132944.171111-1-andyshrk@163.com>
 <20250325132944.171111-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325132944.171111-3-andyshrk@163.com>

On Tue, Mar 25, 2025 at 09:29:36PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> HDMI on RK3036 use GRF control the HSYNC/VSYNC polarity, but this part
> is missing when it first landing upstream.
> 
> Document that it is mandatory for RK3036 HDMI.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
> (no changes since v1)

Where was v1? I cannot find it.

b4 diff '20250325132944.171111-3-andyshrk@163.com'
Checking for older revisions
Grabbing search results from lore.kernel.org
Nothing matching that query.
---
Analyzing 7 messages in the thread
Could not find lower series to compare against.

Best regards,
Krzysztof


