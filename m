Return-Path: <linux-kernel+bounces-558071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB9AA5E14D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE138167588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462F257430;
	Wed, 12 Mar 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba5AEwEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF52571D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795109; cv=none; b=ITWzFfLwceYJR9TO9vwLppIBJvLhcntT30CqZGjMoTlA4jXPLOKlgTXV0AIqhDUY1rj26cRr7KhR8ARFwzScRgeK6spKDXiIZDQgqVT66wqY4OFl3D5ZhpcNQbYRI34AZw3u2IvG+WD34gKExnrvjIV4eRpQKCybms4BCxGgu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795109; c=relaxed/simple;
	bh=osTh0kTm77SuvoIDJCJRCKF2vYvN9ddq8UlIlig7aSI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h1turZax4mZDzvIrN+qj58i5rMNX6WG+oGTUF8rsjPQtK7FVvJHI8poto629wqLBo0mBJdAmWElk9heS2u6Fopf9raDIalKYla5yyNTkXggZOQ43tmcDCZ1lvhlBzzL5gHroYziZm1sho86LkyRXkt89Wn5h5v/ix9GbGtw8nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba5AEwEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70897C4CEEA;
	Wed, 12 Mar 2025 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795108;
	bh=osTh0kTm77SuvoIDJCJRCKF2vYvN9ddq8UlIlig7aSI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ba5AEwEMuiXy9lzz2AAXDXchDbnaxUC2VLXFluNn0DxBoH1aCLg62OX9bDhcPmp/i
	 R9dc3YS0PbeUX0XukfoSvDhnDKs0FIHzURFFH5If5UpOr+jQWIOH/e5NKl4WkgTETT
	 sdSzsktIAOgCt6pjlw1Faejmb1rwC7kkUddchkH7o9aTNLe1A1xjdQ8697OFh86ZFJ
	 cG/T5E//gGp2X3gbT13dd+pYx0ud9IC3GepR0Rm+mgWLbfiL+88kGgp7F/pgUSERXQ
	 MjRbsTiXVKK6vmYRoex6m6QM4oQBH/9OPnc+SuF4NjhcJoDpsBvHPuo0+VYWE7JaSN
	 H8tEBz9cO7Bgg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224220339.199180-2-thorsten.blum@linux.dev>
References: <20250224220339.199180-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] phy: rockchip: usbdp: Remove unnecessary bool
 conversion
Message-Id: <174179510715.536552.15016405189922821330.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 16:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 24 Feb 2025 23:03:39 +0100, Thorsten Blum wrote:
> Remove the unnecessary bool conversion and simplify the code.
> 
> 

Applied, thanks!

[1/1] phy: rockchip: usbdp: Remove unnecessary bool conversion
      commit: b52b330046d16f6e4ce94ae6fa349cc30af027b3

Best regards,
-- 
~Vinod



