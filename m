Return-Path: <linux-kernel+bounces-550872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EEA5652A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24F3177624
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59720DD71;
	Fri,  7 Mar 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3t+BCk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171D20E020;
	Fri,  7 Mar 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343075; cv=none; b=umePw62ZNzdpelbiWpBYuYY/MOEkmy8f176Wf6dm8D8ZsVJyxfWlvmRXMQNGSoyT7NcFqDHyeugQp0YLeDIx9EflgYA2voKwQ4mtkl13TDf7Q8c0DBD/02f7JmjWb4NVBiZKWwn7hdw893psUVFcX0BHluGwk/lKTGj5verKb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343075; c=relaxed/simple;
	bh=Djv5FfsTg2UX6dg4OBS0LDjluXA5XJF6DZ9+8Th4zzg=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=JMboLT26isxFv6dIqjss9zZoF87c/S/p2unCPpgzmnomdDuU+HZYsMK1o4qIhFH0wjvNX5teH2xrjMkUSN8X9axA6aW2hclpgg4M8vyqy2BLoJoYQaR7IK06RJ6Yn8H6HxXoi60nRIjFGxh5DF37vK6XV40tZfQ61rWiCElPx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3t+BCk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A0AC4AF0B;
	Fri,  7 Mar 2025 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741343074;
	bh=Djv5FfsTg2UX6dg4OBS0LDjluXA5XJF6DZ9+8Th4zzg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=S3t+BCk9NLYTS7XjOhYLrvBE1N4GNvPKIldIC1/0Qp6NWEM2GKbT2J25uBb2Crc7L
	 H8A4DpxOooZRRBaszTC6uQnUl0ixVql/Q8ydxXiCTGu3clxD+U4pbb9LVzuJXzfQlJ
	 qvPy62eA0Zm+rJElabY8L4eZ5METZJEaKVsq97B7nzHSNN53om/abizHKPjSyCk2rj
	 y3HXIUPtuhxyfObvWGrL6Yge/43X8o6CO3HkGgSLF8q/QdMf8+JU3kIY3qv/zs45v1
	 MiXgOzBezKkFpVtFFnGMM/kQATct5dX7EOjagStffN2fNVxtf4sbwSVf22As7SuKtJ
	 CoqtIeM8MxT5g==
Message-ID: <249fa2f35689b1b2914ada0179c73e6c@kernel.org>
Date: Fri, 07 Mar 2025 10:24:31 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Subject: Re: [PATCH] drm/vkms: Add "hardware limitation" emulation TODO
In-Reply-To: <20250225-vkms-update-todo-v1-1-afb1e6f7d714@bootlin.com>
References: <20250225-vkms-update-todo-v1-1-afb1e6f7d714@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, "David
 Airlie" <airlied@gmail.com>, "Haneen Mohammed" <hamohammed.sa@gmail.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Melissa Wen" <melissa.srw@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 25 Feb 2025 16:46:22 +0100, Louis Chauvet wrote:
> Add the hardware limitation todo.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

