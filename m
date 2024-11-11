Return-Path: <linux-kernel+bounces-404449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F376C9C43D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A0C1F20FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B811AB6EF;
	Mon, 11 Nov 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCviVRaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55531A726B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346582; cv=none; b=jmjnFC2ZQzjKsutWiA/TwPepv6QcBscTMZMVPZhdqszyGCLRAR9vL6dUX9ACFyJda9qA1vrj/bnut2v1nXNEAsWLsE1wu+BsUUrCRcQzPNxwlXGQaRlK//e9VudEHKiVgDWj+dXBwS7lK6BZXa79lF6fpcQTQWd3Ht0YfAmmDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346582; c=relaxed/simple;
	bh=7ZuQcxLz5pl9W6DLTEKLbTc1I8ZYogcj503IJ/oZocM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p//pdbf0jWMgjn1t+df7A3lOjKJqu9KUxtRIPifpJmozLlZpmFTlER3Q70aiU+SlRTLTtOG4Ny8e5G/CVyUui7iFLD/FoTG4JDDmkNxnn2IKDPP4k/CwpQgEoIZb8ffCYG4vVplnpkpJ9bIuahUI4zmFIW9z3728z1T2rlRb1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCviVRaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7490EC4CED5;
	Mon, 11 Nov 2024 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346582;
	bh=7ZuQcxLz5pl9W6DLTEKLbTc1I8ZYogcj503IJ/oZocM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oCviVRaHa5G3xR/xTjLHXJWpPSIwj1ZhBWtuXEZ9YVOItkIlWDQPTboVbEm8qznrz
	 1Hfa7bNFFyhVLoMCWu1KuW5jnnY8+XrEpO9zht9C3VJpToUxYb0HQDfdRJfpyGNyX5
	 KHJviXZ8UdKKyeFM8F7yMC46cEKq0z5UzUAv9kzScWR51pjmFBGTqG8gz4scBkRYY4
	 YklTmpg6xjclTGFRg1XbxirIlg34A+3sLsNZTfzDo7bDI4NTJUQWjBefAHvitGInz7
	 9xSiMzYkv39Gkkeoy4R+b+6sZ9NnMotCcWO73iTw17/90XIgpNqBdsCrR//OWDs1e0
	 fcqI0Eal+fQkw==
From: Robert Foss <rfoss@kernel.org>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 linux@treblig.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241005232017.305217-1-linux@treblig.org>
References: <20241005232017.305217-1-linux@treblig.org>
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Remove unused functions
Message-Id: <173134657901.654843.2640866407787013964.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 18:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 06 Oct 2024 00:20:17 +0100, linux@treblig.org wrote:
> cdns_mhdp_hdcp_set_lc() and cdns_mhdp_hdcp_set_public_key_param()
> were added by commit
> 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
> but never used.
> 
> Remove them.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: cdns-mhdp8546: Remove unused functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d84927a4ad92



Rob



