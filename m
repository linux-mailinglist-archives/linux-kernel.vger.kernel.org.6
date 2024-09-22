Return-Path: <linux-kernel+bounces-335290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDE97E3A1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90896280DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176575804;
	Sun, 22 Sep 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZtHQMIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD7D6F077;
	Sun, 22 Sep 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727039150; cv=none; b=dnDxOwM/d70evP3xvk0k5BmLDgTVoZbwkn5PvyoKilxg2nKddpGnGDhZRAlifxmNdDTXbPki40VbQhwMLdJFFohoEBeUTQ1sEAkwQNEb4CeH9khykBMA/QmZAYT0rl5O07r9uZhyb/DSiRVvquGFSAZ5aD/YtF+3FES8nBgtGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727039150; c=relaxed/simple;
	bh=aBAPLqLjEzVqTPoaZP+3I2Os2qBCGy/KC+3yMQvfbp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+3+TaAxWcff5TXvn2jYMM3ntlNtkwgOLUu2qGfL+W+ZjmyI7nqTpF4lg9O+0YOHFWR2AlQJRffDFLMcKkaaZvMtd0KcFscT3GhfCh+1euZF0XAlogR9OKcODntuT3qILBRK/NxlBEfJOxs+xeTO6TEeNVKNUZGk9270xXmWu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZtHQMIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B43C4CEC4;
	Sun, 22 Sep 2024 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727039150;
	bh=aBAPLqLjEzVqTPoaZP+3I2Os2qBCGy/KC+3yMQvfbp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZtHQMIo+VxF9Va1Wqn8JBC2KEOy4MaCv1BosGHT6kk58QqdWb0f3DH/G5VBcfk16
	 D9ExWXyhTFIjm/QBfWAICa2rUd56NuQBLkubUAOUOJ/5oBEVnzzIcDzu6dvXnDVMGp
	 YtltRShzJEWMjI6uezinpPHDnoZ+oHyoOrQ/eJfWwI+xqMFpIDg279Klst5TQWgDke
	 7Yc4arcYpsJw1QkY8tOsg+M42JeX43f+U4pHg8Une+qZumCFmvvXD+oVgc/Ou2VTke
	 a1a5QyAlR03EIrDdJUeTe2R9LAesjiNksJvEiqTpjbdz/c02LJpffyltjNw/4ey8YH
	 XeAVHh+5tl1gA==
Date: Sun, 22 Sep 2024 23:05:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, krzk+dt@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	derek.foreman@collabora.com, minhuadotchen@gmail.com, detlev.casanova@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 14/15] dt-bindings: display: vop2: Add rk3576 support
Message-ID: <vv3fxx4gqcd3oju2v75dinwdajmfkre4c6wvcm2cpit2wgcsqa@7ykznmou5t4t>
References: <20240920081626.6433-1-andyshrk@163.com>
 <20240920082306.6982-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920082306.6982-1-andyshrk@163.com>

On Fri, Sep 20, 2024 at 04:23:02PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add vop found on rk3576, the main difference between rk3576 and the
> previous vop is that each VP has its own interrupt line.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


