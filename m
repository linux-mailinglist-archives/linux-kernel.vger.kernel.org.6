Return-Path: <linux-kernel+bounces-429888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9114B9E2832
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A2D165356
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC81F8EE0;
	Tue,  3 Dec 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKJ6etyZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BE1F756E;
	Tue,  3 Dec 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244766; cv=none; b=pzLMYcbdvzmz1om+ClpS6GM9ioREAjYAR4y2ZRzuAb40dfe1Sf3OEf2fZjJ5KUNcJVh/MB09eV8jziys1cDqUeZXoa2ewt9CeVHFYrYEDdJsF14f+Ow2ydqhIxewiCWRqLclzjvl15E/vKAoUOPm35MBbGSZFBDTPUS9mdngKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244766; c=relaxed/simple;
	bh=I8I+dhZpF/dN9uHNRQFTrUQz+PFUAZBF99lsuTvprzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErkPfF2NVx5MV40jGigmuiZsTn4npEUAW42Id5fF6q1Qx4/XZU2yq6tT+Qml7ELhW+iZTLREagRLMJIYY5HjZJwUkEsg8d2bFmqf1OZYGBJndgf+IfPWnbsIGKPqQsZH/WnnvPOlwVj85phIhyDlBM93ECUKVH9obW83fLL7dQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKJ6etyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC71C4CECF;
	Tue,  3 Dec 2024 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733244766;
	bh=I8I+dhZpF/dN9uHNRQFTrUQz+PFUAZBF99lsuTvprzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKJ6etyZmzEdINsl2+6kcmoyVt1Mu1n1IIC/kztXxOKDTr+drPVMx9YUOxsWM2aCk
	 gaJVGLmBzoJA0Ee3qoUlGzkDcfu8paj7T2ytqHspxHxohUmDK3i4mOkJYXcwy8sRbi
	 6rtI/Qo8HsNUVcNniEiYE4niUBXYI25aOPzdDMXBhnmJpPTvvgMtgOxlHsO5XI5Dmy
	 ht1YoJAapQ0VA9jrPeOXETG00wX3p99+5qxl/rs3WnsbTkUP4W0jJUzr3etCEZd/CB
	 MIpRZpbYDsN04fpEK5H29ugsuUVhsGWmEYxX0vJsCKZgqgThSFs9ZlWL+K81chFj70
	 n0Lxzm80hrE/w==
Date: Tue, 3 Dec 2024 10:52:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of/fdt: Implement use BIN_ATTR_SIMPLE macro for fdt
 sysfs attribute
Message-ID: <173324476215.1949223.15229221375993731416.robh@kernel.org>
References: <20241122-sysfs-const-bin_attr-of-v1-1-7052f9dcd4be@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122-sysfs-const-bin_attr-of-v1-1-7052f9dcd4be@weissschuh.net>


On Fri, 22 Nov 2024 13:14:00 +0100, Thomas Weiﬂschuh wrote:
> The usage of the macro allows to remove the custom handler function,
> saving some memory. Additionally the code is easier to read.
> 
> While at it also mark the attribute as __ro_after_init, as the only
> modification happens in the __init phase.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/of/fdt.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 

Applied, thanks!


