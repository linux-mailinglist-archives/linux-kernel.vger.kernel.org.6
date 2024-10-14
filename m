Return-Path: <linux-kernel+bounces-363409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5899C1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CC11F234FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2414B94B;
	Mon, 14 Oct 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMu+wSa+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849E14A092;
	Mon, 14 Oct 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892207; cv=none; b=OipfS93hSo37BTGD52g32UigZGCFojkAPM0zkE4+Yx8vXMnng8VRaz8XRg3TveWu9ZJ7QfESCTP17j0hUbr3ZOUeM7vFEG9OZgObHWnMsW1wdRW3VSVmuONyeGRHMLG1TpAXD8yHDc3iO3bDUbJcoviDDA5xtPSrQLd5wDrPeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892207; c=relaxed/simple;
	bh=68BtYOJ0iBMDXJQXHUmn2tYbU25QVRkH69nn/i8UgLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx0vUSlpOqdmSfToAt+2MfsIcJdx+OszzgI/CzZJfZ2Xnk31azTnUd9vw8gUcEel8WKnt6uMEcI+wSwAzniyo/VoKEK1oWYZbs/RWXoZogjP0i7uxfdw5svx6gRUG/1pMoCjGIKPAbSeVZCe9C2Dhgy5GXERoi2AR5kVa1MWP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMu+wSa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460A9C4CEC3;
	Mon, 14 Oct 2024 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728892207;
	bh=68BtYOJ0iBMDXJQXHUmn2tYbU25QVRkH69nn/i8UgLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMu+wSa+XlrL6fQrA1Y+uhwPowC2xRJxNRn6ERfmMhH4bsuGHyo95ARsZn88sq3QQ
	 PbbgmnJnLFSXlxiGv/oQSkH7zeCuB5e4cPZiV9SFqnnUruS1m5Lue0NDfrU+vbCZhW
	 asvFDZGR3cdjevLmOtUoFrOSjwr2enjjD3SIzc1+CYrxGPrfPhUdrrHA46W8E2g85O
	 peR1tDan4WsQvVkfLeSb9iOImOPVy/8jbnW/yuNY02pKhkpjsoSkzA6d6DNu9dMRx+
	 dQkHEakxOoxzBT9DrHhxVfAwGOCnd39uiWaz+j/nDtQodE4p45dK1E939M3NWKutQi
	 4cV0TcKa0BZjA==
Date: Mon, 14 Oct 2024 09:50:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@mainlining.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS581VF01
Message-ID: <pw7l2ilfioc5o5rmko5rxrfzbhdzm7rudnjg3s7lu47wxt73yq@cixu5oa2domh>
References: <20241013212402.15624-1-danila@jiaxyga.com>
 <20241013212402.15624-2-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241013212402.15624-2-danila@jiaxyga.com>

On Mon, Oct 14, 2024 at 12:24:01AM +0300, Danila Tikhonov wrote:
> The Samsung AMS581VF01 is a 5.81 inch 1080x2340 MIPI-DSI CMD mode
> OLED panel used in Google Pixel 4a (sm7150-google-sunfish)
> 
> Add a dt-binding for it.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../display/panel/samsung,ams581vf01.yaml     | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


