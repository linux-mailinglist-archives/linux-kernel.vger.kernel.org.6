Return-Path: <linux-kernel+bounces-246025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B14792BCDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0428C282159
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE41922D8;
	Tue,  9 Jul 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e6DD8off"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E128E3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535205; cv=none; b=QZG/ldZA9/VdMcdAMdbSmo2BDa8Fb35i0yDiZme2Gx/FmV7R0YYTbjrBNbud8SzNbEXtHIdoOyYLbMEo//bkveAANOnUhcmSdjz6DHOvscIq5ngPoEsd8rv+is/k5AUhAWCxtv7m0+iHO2LbihqKYyh9gmYKAgd2/7UEO2+veqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535205; c=relaxed/simple;
	bh=LcJWI0lnnRGA05VInMkzaxz4JycYrmj40ADkve6WVkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6gjYkt+PBEZ02hLi24/WW5M7zcAfFjCphXkznfp8aHwiAYp9rX5/zvM9qjJ7vEH96FXDaepHGMK0XvG2zxHMhVjIm41Tan4tAMEzTnnRcnaPnQjn6fzlcn6NgxAIhz2BTn679ew93SZNMtFDbAewvoyHA+jfRRfYK4PxKMyELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e6DD8off; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EBEC4AF13;
	Tue,  9 Jul 2024 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720535205;
	bh=LcJWI0lnnRGA05VInMkzaxz4JycYrmj40ADkve6WVkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6DD8off//V/Z2Uxb52DOyHhc0N1B5QcJCM9LMh8+B5ownQxlWoTk19H5QUNEZfrn
	 /RB536QPWB8cTNEJQePX9A42yu1vYTrlscffCuwXLSlR63gUu2ECC0H8+XOYbGWhb6
	 GGwNt6G7pVe9uLdU8LLKHN71/tnuddcIum83t/9I=
Date: Tue, 9 Jul 2024 16:26:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lizhe <sensor1010@163.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] driver:core: no need to invert the return value
 of the call_driver_probe()
Message-ID: <2024070911-stinky-enjoyably-1a1e@gregkh>
References: <20240708134028.3508-1-sensor1010@163.com>
 <2024070829-zen-remake-6bfa@gregkh>
 <38a8f6da.ae7e.19097de3e54.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38a8f6da.ae7e.19097de3e54.Coremail.sensor1010@163.com>

On Tue, Jul 09, 2024 at 10:20:42PM +0800, lizhe wrote:
> 
> 
> 
> Hi， Greg KH
> 
> 
> 
> 
> have already submitted the third version. My name is 李哲. In pinyin, it's Lizhe, and my email is sensor1010@163.com

Why not just use "李哲"?  No reason we can't use the proper
representation of your name in the changelog, right?

thanks,

greg k-h

