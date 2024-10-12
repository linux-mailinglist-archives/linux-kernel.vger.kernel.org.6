Return-Path: <linux-kernel+bounces-362188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C699B1E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAC284C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A571422C7;
	Sat, 12 Oct 2024 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lHmcVzOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F713137742;
	Sat, 12 Oct 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720023; cv=none; b=kJGlTFlFV2JQ/sKDRWkTNZlqquKAvUHrRajG30AKYiayY5Fcwn+AZ9V1k6YCLBsxp5qWLSbJcULUG8JxUAXe2DbsEdpeCRSV55IxI3SMZA293cvieOu6RONaC46sfC7hq7MnqVK1mEz5u23Zk+SqlP1k0XO8IT6QjQMHcdRjilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720023; c=relaxed/simple;
	bh=KDPHCkYH5/I47dkNC5F215LD6/kevJLyuC7JvbB+4Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYlZB+jVndPBZdg6/DPqPd7hbeHK1eQogUK+2Em1emsS+vW74W0oLkFXM6Q0B7Xpr6KN+Fg494vs6LDkvOXxSrbP+tENIJE8E6zgXtnTnfwde9UHu42MJlpRidJNMMyDiv6HvCnOiYN8lYpWWgGZi6suihEyuYiXz928Y9Fv8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHmcVzOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E01C4CECC;
	Sat, 12 Oct 2024 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728720023;
	bh=KDPHCkYH5/I47dkNC5F215LD6/kevJLyuC7JvbB+4Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHmcVzOtlCtTHIp5BeL3//byQttQ1KT1tmV84OoivebIs0T4t4QZt9kB0oHEiIQp6
	 x9ZYveNWjfMfhxIRpRuS7itkKYzUjBrXl454gAFBkIgkBrqxoHSsda6ev+bW6VTRLQ
	 zIeoEUpITbc1QFDitnolGFt+KTjeccZU6abwx/9c=
Date: Sat, 12 Oct 2024 10:00:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Teddy Engel <engel.teddy@gmail.com>,
	Michael Straube <straube.linux@gmail.com>,
	Sathish Kumar <skumark1902@gmail.com>,
	Florian Ziegler <florian.ziegler@posteo.de>,
	Pritthijit Nath <pritthijit.nath@icloud.com>,
	Arnd Bergmann <arnd@arndb.de>, tdavies@darkphysics.net,
	m.omerfarukbulut@gmail.com,
	Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: Re: [RFC] staging: vt6656: Proposal to delete driver vt6656_stage
Message-ID: <2024101251-sherry-matchless-a5f0@gregkh>
References: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ef2954-21d0-4ddc-85d3-1334e7270ced@gmail.com>

On Fri, Oct 11, 2024 at 08:59:44PM +0200, Philipp Hortmann wrote:
> Dear Sirs,
> 
> Forest Bond contributed this driver in 2009.
> 
> The following points let me propose to delete the driver:
> - This driver generates maintenance workload
> - This driver has a maximum 54MBit/s as it supports only 802.11 b/g. Peak
> throughput is 3MBytes/s.
> - ping times can be 17ms are often above 500ms and worst case 22 seconds.
> 
> I suggest deleting the driver as it no longer meets current expectations.
> 
> Former Maintainer Forest Bond <forest@alittletooquiet.net> is unreachable.
> 
> The staging subsystem needs to focus on drivers that support usable hardware
> that is available. Newbies can then get the hardware and play around which
> is fun.
> 
> Please consider that support will remain for years in the longterm kernels.
> 
> Thanks for any response about your thoughts.
> 
> No response will result in a patch for removal in 14 days.

If I respond quicker saying "yes, please remove it!" will you send a
patch?  :)

thanks,

greg k-h

