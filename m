Return-Path: <linux-kernel+bounces-558229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FAA5E308
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B991788FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DF24EF90;
	Wed, 12 Mar 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVvZvqd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543F155A4E;
	Wed, 12 Mar 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801630; cv=none; b=leKDHzQ633A/j8VR/884sl/hqwSDOhEQ3GTtRPe5eBCk7dWlEe5/IjHM27lf99h2fF/+dWXDTiHkl3ib4YcTxhLQFRBPBaqRpHa2s8j7KQ0FAQhXGR8NB9UsODhnVdGVHU3+9PIvYWHOCBOJZFKewg0Wh1o4WCSlW61GVJ2ZBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801630; c=relaxed/simple;
	bh=zmQQxNDH4Fds7Lcdf3Pm1gb9moqE2cmfjzhZ+FDb8SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIEUF4OunLOSXPhtZR4kLm65iDdlhUWnUXusMG0vx+mhziYbdIIjiCI7twVpGlJjKGhGi/L6AwfD1l7o3w/KP9yafbXwK3bcvkSAofkhxAE0zJy+VH9av8hkioC8d6DkV8+WwxYjipUmQRha9IwFm9y0bJIvtpfndI6N0y9xZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVvZvqd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6654C4CEDD;
	Wed, 12 Mar 2025 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741801629;
	bh=zmQQxNDH4Fds7Lcdf3Pm1gb9moqE2cmfjzhZ+FDb8SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVvZvqd2xiTRKWSk6B5HnnmfMPfllsLcFKQ3KQjJDQDPiuDAIaFsYRRt9ZTc049TS
	 Qb32a+zt+4FtuVxg6+5Ru9tTE/oP7+9XLwr3ehmfFQZ7/tc9tpxVMdZPE6LNEd7rZd
	 5F7aVHsryiWrjFBCdht2ypdgmJvBKnHANHfUn2HhaZIT/0+jfIHohpsy91r2kPmuGF
	 jKf56PZIS27Es5uN28dlvssqrXeRdYN8x2k6SPV3kuZb/+cV8bH6HQ4jMWNTO2agbX
	 sxflb5Qc5cmqhU8JcVKhhiWwvYg1tgF3aTKoOMxiQ2WcAdb7EgqsJD/zCnPKx9S5m0
	 ZEbhSXIPn1/yQ==
Date: Wed, 12 Mar 2025 19:47:05 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/display: hdmi: Create documentation section
Message-ID: <nntv5x5niu33zjxpdlx4zr3zbdvl6mugx34btgejbdgusw3j5i@oakkwqs5mtm2>
References: <20250312-drm-hdmi-state-docs-v2-0-6352a5d68d5b@kernel.org>
 <20250312-drm-hdmi-state-docs-v2-1-6352a5d68d5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-drm-hdmi-state-docs-v2-1-6352a5d68d5b@kernel.org>

On Wed, Mar 12, 2025 at 02:39:16PM +0100, Maxime Ripard wrote:
> We have had documentation for the public functions in the HDMI helpers,
> but those were never referenced anywhere and thus not compiled as part
> of the doc.
> 
> Let's add a section.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  Documentation/gpu/drm-kms-helpers.rst           | 15 +++++++++++++++
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 +++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>

-- 
With best wishes
Dmitry

