Return-Path: <linux-kernel+bounces-346993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896598CBC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F422E1F25410
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B917543;
	Wed,  2 Oct 2024 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S00YDOk0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638C14A90;
	Wed,  2 Oct 2024 03:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841299; cv=none; b=Uy5aLAX3jVQ94av9XM5ZYZJUdoW3qUYe7lkKzRrNSmqUQUIvQbNvp36TIn6G5dg9rsYX223xIteygx0Ta9bogRE8Uckq+IgiFlBxjSAcEOZ0oTqz0+rO0mF33l11nHYxfAOApJKxKuAKmt3zhd6Kele2AcxlioXLoo5vGhhiwQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841299; c=relaxed/simple;
	bh=LG6BfmSiNR27N+9l6sKUikVPDX0YWr+bTu9pRgKVAoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KM60iEPpGINK1b+tuT5kjlF/n4lqVAPc1SIikO9w7j3pNA0NAmg8AYQywb3cywM15e5OCDqKnoBpO06tTn5kkP/RqJBAFZHUequmoN93KC0mSNrSYGl3jX1CtSg73VFSBK3yXbESgXutiWQIJ3aaWmwtwu8mcyHWibkGZ0ZFPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S00YDOk0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b4QwsyLK3zmAWkKcdQfNeA69tjYl94ObfHaSmrcR3cE=; b=S00YDOk05KEIob5Yw1u7bpwRHD
	Ly1wsF5/QMuMLVzEc1oipeANl/ZKNV8FJ5NrhbMcLY35zIuKlKzeLskmHm8H9R1Btc+4sDBvZxP+F
	Lq9n9NbXTkDrV+6bsQFfyVqJzIBonZh1SkSZft6IA9ahz8gghGtkFCW41/gnEjVlxXNP2xz21y/ak
	vyisq5UDmRBS1HCjIy9PUklrFp4+dB/WSGLxGgYJbfELQ9ohyW2HNvBXlJ6w5If8ZE4N7O2GRkCmQ
	YgYUZGKHlbKQCiWwq3IO9P2EtV3uzOfV5bA7IZmFysPwiY/Iy8jJ5UPmEYixezQaoRmfVZ9QuRsfd
	dsfD6ZXA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svqRs-00000003QQj-3PMD;
	Wed, 02 Oct 2024 03:54:49 +0000
Message-ID: <30573f5a-d3dd-4aa4-ac5a-cf6df77b79dc@infradead.org>
Date: Tue, 1 Oct 2024 20:54:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/15] drm/vkms: Avoid computing blending limits
 inside pre_mul_alpha_blend
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, arthurgrillo@riseup.net,
 pekka.paalanen@haloniitty.fi, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240930-yuv-v11-0-4b1a26bcfc96@bootlin.com>
 <20240930-yuv-v11-6-4b1a26bcfc96@bootlin.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240930-yuv-v11-6-4b1a26bcfc96@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 9/30/24 8:31 AM, Louis Chauvet wrote:
> The pre_mul_alpha_blend is dedicated to blending, so to avoid mixing
> different concepts (coordinate calculation and color management), extract
> the x_limit and x_dst computation outside of this helper.
> It also increases the maintainability by grouping the computation related
> to coordinates in the same place: the loop in `blend`.
> 
> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 40 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 931e214b225c..4d220bbb023c 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -24,34 +24,30 @@ static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
>  
>  /**
>   * pre_mul_alpha_blend - alpha blending equation
> - * @frame_info: Source framebuffer's metadata
>   * @stage_buffer: The line with the pixels from src_plane
>   * @output_buffer: A line buffer that receives all the blends output
> + * @x_start: The start offset
> + * @pixel_count: The number of pixels to blend

so is this actually pixel count + 1; or

>   *
> - * Using the information from the `frame_info`, this blends only the
> - * necessary pixels from the `stage_buffer` to the `output_buffer`
> - * using premultiplied blend formula.
> + * The pixels 0..@pixel_count in stage_buffer are blended at @x_start..@x_start+@pixel_count in

should these ranges include a "- 1"?
Else please explain.

> + * output_buffer.


