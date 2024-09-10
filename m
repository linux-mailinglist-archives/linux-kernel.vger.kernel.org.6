Return-Path: <linux-kernel+bounces-322728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904B972CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5361C24726
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F354188A10;
	Tue, 10 Sep 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fInl1ysE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F5188002;
	Tue, 10 Sep 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959081; cv=none; b=BGprnmZDbeohCnxlM/77y9xjGZzMjr7OLuM7zFu0/bAnXTDMoBORSLj0zkHH8GCPJazOPkmg/WqBk9FDLS3s9lXp9Mo4E1EDuvV/MpM+l9mkiPrDPfX6+s6Et+VaJTC72YejPtsZ+aBnUkDeZS766Yid1O6/jWixMqlzAcrD+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959081; c=relaxed/simple;
	bh=H8CEp2/9jZrHleI1Lrib9tpsZICUCaPP2NNzePDTsIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeXlVRew8taF5ZCpcCznacLnhEdr9Y9PSmqoZdHTFR35lO2YQ4oAvYLyK3Fs3JSkgAJn3IadgrrbHp0Z83L7f3knOt2QVmocOhG322kbrnRATjWFK6zcXGz04imCL8knvjzroea99bWtmrAfS2aqw/WQIZaOpPyNg6gzMtdHYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fInl1ysE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE07C4CEC3;
	Tue, 10 Sep 2024 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725959081;
	bh=H8CEp2/9jZrHleI1Lrib9tpsZICUCaPP2NNzePDTsIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fInl1ysELlfXBZ5rZYn2C/8XqQLsX9jQADNKUFYC4dz5+tzaJtJEO4bVWL9R8maC3
	 DX/P4UdNMPHqSVVJiZr2wmElhDXGXpC12K4kRpJQDUByzOPfLZTCrm41R2KzFRMjRD
	 qD6euzDvj060RN7da5VT79JnSJqlMou1uR7pn7oQ=
Date: Tue, 10 Sep 2024 11:04:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: rui.silva@linaro.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: isp1760: Use devm_kcalloc
Message-ID: <2024091053-deforest-acuteness-7d20@gregkh>
References: <20240910072642.39396-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910072642.39396-1-zhangjiao2@cmss.chinamobile.com>

On Tue, Sep 10, 2024 at 03:26:42PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use devm_kcalloc to simplify code.

In what way?

Are you sure it's safe to do this?  How was this tested?

thanks,

greg k-h

