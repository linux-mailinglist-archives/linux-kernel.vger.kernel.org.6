Return-Path: <linux-kernel+bounces-556418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0895A5C7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB63BA160
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40B25EFB6;
	Tue, 11 Mar 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAqF6az2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA13EA76
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707115; cv=none; b=FohHiVQw6THvrL7gxFIoYYRPvpwCCIb+EG1HbQKx3oxcLrJWIlGw5OWWn2wfVUEAoK+91zMxSUYFjhAkMlmdTCJxxtKsiTVvrAFwlXZOdEpdOUn0Y40Yx3AzCkfo74oXJ9+wdRtIqsKlJ+SX6LmvSyTbYV6LiTfUByGkmLgb4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707115; c=relaxed/simple;
	bh=vBIIoUdY2jnOBh9TENywlRyR3Iz722r2sAB6WosjOnM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Ppf7KIfJSiwRvfHpvjuwg+mEgtRst8GFtlZTi7kWXZNsEkiz6GkJLOdaE1abD1oIywkYQqG6zwN82uOpa2iQCJu9Cx9+xH7OxN8bQSwaGScsifygU0SKLjwbKWEPvsEz8UZW9lvJQ1UCyj+o+JVFLraebiVmRhiRSN/gRTsZVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAqF6az2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5D7C4CEE9;
	Tue, 11 Mar 2025 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707115;
	bh=vBIIoUdY2jnOBh9TENywlRyR3Iz722r2sAB6WosjOnM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=DAqF6az2NTDqpb/Y5Ff8KHol89GMopQ0aK8Vm/5zJ5e+IiedwLkZIr/NVPdy253aL
	 34/s6P1LkOdmluMtDC3Y9Rb8hgULVO14tTzSr0hdmhAk0OvGtnrJDI+ZDci/SMgaiA
	 dNo2FhiievmoQqg5Ux1GFWE6cwjNuhgZVb63zMbi0YKMnbo30Ne68Osne8+rMfbzgJ
	 tdhGhwv7fFE49vjvXdbUU9RSYTSy9G2ophl9VSTsBJtoEdDrwEMf+gZqgepzE36lWl
	 xI4i4R2X+xTLruIlFtquM/sDv/kfwe1XLDUgpHddv3Z5MhkiSHNwogwlo3bVg/b5uT
	 p1mWDnEeOqN5w==
Message-ID: <8852bd6be2d3ddfb65d0ded2b1769d46@kernel.org>
Date: Tue, 11 Mar 2025 15:31:52 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 3/7] drm/connector: hdmi: Improve debug message for
 supported format
In-Reply-To: <20250311-hdmi-conn-yuv-v2-3-fbdb94f02562@collabora.com>
References: <20250311-hdmi-conn-yuv-v2-3-fbdb94f02562@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 11 Mar 2025 12:57:35 +0200, Cristian Ciocaltea wrote:
> Add the missing 'bpc' string to the debug message indicating the
> supported format identified within hdmi_try_format_bpc() helper.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

