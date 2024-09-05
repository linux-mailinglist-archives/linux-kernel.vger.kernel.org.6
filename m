Return-Path: <linux-kernel+bounces-316440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A1B96CF9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98402B217FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA99191F60;
	Thu,  5 Sep 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB4oAB5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0E18F2C3;
	Thu,  5 Sep 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518694; cv=none; b=VowoiB8IFYNabacDw09mOpMuKeAsr6FtmrAwbZDdT+PVFYSPlxGaG/IwzSU/52CnqAIBJEd88pvqbUpJ9ncHZ+OdHTD52TYbSJCSbQgxjxVuzX94NI5QlTEkQKrhEpMKhy1VH8LCMP9MIFsDCb3P2BGPUPGhwmmFny0N/tqJtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518694; c=relaxed/simple;
	bh=WmzPeAppOYGxw2pBZvSCYqbt+9JNVBVF+BuOfIdFGkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUfX6PU9+307rFEKjzX1v4gSVqB4CQn6lkZATouwN5LMGRYhBjbh8nh4E0XwDOIRipsqeg7O+PyIhAJMfubLCR8oAia13nRJbT0jxlMc9Q6RGAwv0j1jQTvJc6y8yQWohpgcH1B9BOPklEiXCFp4WVGK1s8fN/+KiWVeq+Jo5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB4oAB5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA010C4CEC4;
	Thu,  5 Sep 2024 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518694;
	bh=WmzPeAppOYGxw2pBZvSCYqbt+9JNVBVF+BuOfIdFGkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MB4oAB5bspDlg/3ddcsF3JbDbp2dSDH9wHLkExf3zfRms5OFlvh1uzCycCC/IaQwo
	 ghaOJGqPxG1tXm/zKfbSK/RPg/Fnf6uULoaAmIo5FBy2dsmE08vTeRnZmubl73Quww
	 qCKtoWqIkb5WkAUKAQj4WBskD6C/Dgk/nVIl21h7wn0zzy6rOTGCYNxWdG7jUqcsiz
	 rV6Nvxr+QoZflZmQ2A9Z0r08h2uHbh7LpCzGAQ8RekbGMwVPgHkviWTCxW63WGjnf4
	 abKnlYRtinZgm+tb6Vw6r3DG6CmbJAFo10ZIPvb3eklVVQH+uNX9ePxHjWdqaSqEQx
	 1WqH9DAzI1ijA==
Date: Thu, 5 Sep 2024 08:44:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	kernel@pengutronix.de
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Message-ID: <e24uioplsxa4iu5m2ecn7apkpkmz3lukfyypngmsmp27ikxnbc@4cwxk2hoeo2r>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1725503468-22105-3-git-send-email-hongxing.zhu@nxp.com>

On Thu, Sep 05, 2024 at 10:31:07AM +0800, Richard Zhu wrote:
> Add compatible string "nxp,imx95-hsio-blk-ctl" for i.MX95.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

This one here is so trivial, you can squash both patches.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


