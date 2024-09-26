Return-Path: <linux-kernel+bounces-340157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE59986F31
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65B72860EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D71A76D9;
	Thu, 26 Sep 2024 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evlfkGdn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6D1A7256
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340421; cv=none; b=NvHFF7vFWFACldIk7sR1Zk9XAoxsN8+ziX1drlRore7kP7w9l81Bj9fObQeN+79+vHP9aMTuPVOvuW8kdL5z5u+2W/xWnU2pZsDEWVWBYvB8BKpEpUyTu0X7w4NpuNrn+/Tr2VXTyAfUAHBqa+lYjQDlAAioWCaRmyNAMJlOyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340421; c=relaxed/simple;
	bh=VKscj+DO76Rzsw+H0qxTe4kRpneZQShQ4hJuK93SmFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beUKVZYexLwSc7z9fEHaGvQbqB4dia9K5GYS8PYSpesAGLM2G31GS0p+HSw/bLNd9Fn9pURBn+arEY9JJs4Zo+3lCw2nbT0FIHZMTu7qNBXycT5em3jQazdtkw5b7P7c82yf1u8jK4fFIo8IS8Ao6Mp7AwXX06xRnJO460iX0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evlfkGdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9E9C4CEC7;
	Thu, 26 Sep 2024 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727340421;
	bh=VKscj+DO76Rzsw+H0qxTe4kRpneZQShQ4hJuK93SmFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evlfkGdn3XL9XZTWgQBDfJ409VAnt8ug4FLXx+l0Lbrht8EUVCSXyWQwik3ZHYSbs
	 EyOOWmBhotEUI/bvTRShkQdpNEbacCEmMTQzskl2NkWjDbaX8DnSqTRPoozJPbcLwr
	 +VNR+oJu9qu35WqzXWQx8EcmlT0poFUopMe9lcjk=
Date: Thu, 26 Sep 2024 10:30:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: arnd@arndb.de, W_Armin@gmx.de, jdelvare@suse.de, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: fix spelling of switch
Message-ID: <2024092632-perjurer-gossip-a710@gregkh>
References: <20240921134128.16870-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921134128.16870-1-liujing@cmss.chinamobile.com>

On Sat, Sep 21, 2024 at 09:41:28PM +0800, liujing wrote:
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Please use your full name here.

> 
> ---
> V1-V2: fix title description, move cacography to spelling

You forgot a "v2" in the subject line.

Also, for obvious reasons, we can not take changes without any changelog
text at all.

thanks,

greg k-h

