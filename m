Return-Path: <linux-kernel+bounces-543232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E076A4D307
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9822172B85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F441F3B8A;
	Tue,  4 Mar 2025 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXMmK82y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19562905;
	Tue,  4 Mar 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741066370; cv=none; b=Nis//QNEfC9AL3YXjry1bTgqTptFNSZmn2oPZfLKzEjJ2qdZnvgS68/LWlUahRvvFtAech5PiJFGMjLU2AZ6lOZiwWnjJTOR2h7Et90Y3GAu3urmpbRNu3KKHY07fJfbURGnKZAcEGBd4aglVNhhXJFyEONjGjrDSATiuvFunwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741066370; c=relaxed/simple;
	bh=Czmo0lHkTJP/JPuzLGITKE4t4wNcW1o67IGDWuYFQZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHCXQkqvJtFZO4w0YYiSxn3S69OlkgvE2H8pmyB4vfHXUnhiqlLlHDT7BOY/Rt7jrRrEUg0AzIIfUGdAtpkExbFpEXLLZBUx+HyEn6PD6ztPzjX4Ms99iFnfntjjcPBEV47f/gN+HBmYo1Ih4Mk8g1PrLHqMZNnGeESl04xzwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXMmK82y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06ACC4CEE5;
	Tue,  4 Mar 2025 05:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741066369;
	bh=Czmo0lHkTJP/JPuzLGITKE4t4wNcW1o67IGDWuYFQZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXMmK82yVJfPQEa8vEo2Da5H5EFSJ7OjxC/3T0hsYo8bax+2SSt9hcLEcFk5PqhmE
	 ZWdTVYQ2Bifs+DAHfIUJU810NqeuNQW5Pa2LZCQOKybt/OfTnpi20ZmEQCEX8tLqpA
	 0N41Z0u6zD5E9zmNoMDTIVuq5+M0LgydL8YNdgNY=
Date: Tue, 4 Mar 2025 06:32:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Johan Hovold <johan@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <2025030429-saddlebag-acrobat-21d8@gregkh>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <DM8PR11MB5751CB62C7A68840F9AC7F9DC1C82@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751CB62C7A68840F9AC7F9DC1C82@DM8PR11MB5751.namprd11.prod.outlook.com>

On Tue, Mar 04, 2025 at 05:25:38AM +0000, Ng, Boon Khai wrote:
> Hi Greg, Johan,
> 
> I hope you are doing well.
> 
> I'm writing to follow up on this patch I submitted for the USB FDTI driver to update the VID and PID about a month ago. 
> 
> I wanted to kindly check in and inquire if there are any updates regarding the review or integration of the patch.
> If there are any issues or additional information required from my side, please let me know how I can assist in moving it forward.
> 
> I completely understand that you have a lot on your plates, but I would appreciate any guidance on the next steps to get the patch reviewed and potentially merged.
> 
> Thank you for your time and attention to this, and I look forward to your feedback.


Should be in Johan's queue somewhere, if not, please just resend it.

thanks,

greg k-h

