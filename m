Return-Path: <linux-kernel+bounces-258470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A689193886C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15201C20D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588F17736;
	Mon, 22 Jul 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpMA2tNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B92CA9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721626533; cv=none; b=dzPTRn9xlobCIizuzvOLdBJg6tTmbnKnydjnubP81a4yVQ8XU2G9JLgzdjTHbe7hbD2yckXo034+TDijV0FZfTqeKV/EtSs/+AiNnm8640rNMTw13zWLJHgxRFlmsmjJzdET0ZzciYo79PDCJ52PsQX8pL1PfQR61FBIugSlqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721626533; c=relaxed/simple;
	bh=g8gstEanwqClSguFDBJLf7jvTZ10/aTAFuLOKv2/bb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRzaB4qdjGbCi8yt4JLV4sFVFCPxpNu07b9BcKhyeMnMKz5cHUuMGDMmNnG07hsNOf/LljOsWxFQGXcoYvEN0FNQaCrG9IShdldg5RLfvUgWpFVfTwfo/0keseDoxJAF/UvAAhSB4IkbKT7cqKE1AgYO8i9I28Xwm9SNxjqT2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpMA2tNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D6EC116B1;
	Mon, 22 Jul 2024 05:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721626533;
	bh=g8gstEanwqClSguFDBJLf7jvTZ10/aTAFuLOKv2/bb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpMA2tNeZqU88r4DwLc6ybt1mJmzGsCai3dpMrF754sCNraZ0POVbbx5vviGwZdZq
	 Fg8iqw63jLlUvlWGTkSNnIQcfadZeolR+oDY91X3zh1HUTcAqMeYd8oPxjNUq0opRp
	 yLhUm8ZnAETincFJJWPTTaboeHW/vBx8NDA3VkIU=
Date: Mon, 22 Jul 2024 07:35:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, nikhil.agarwal@amd.com,
	abhijit.gangurde@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
Message-ID: <2024072255-storm-friday-f18b@gregkh>
References: <20240530233436.224461-1-linux@treblig.org>
 <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com>
 <Zp2QBoqAjKjABfJD@gallifrey>
 <7141e8f9-db0f-43e0-98ed-c3e2c44720d7@amd.com>
 <2024072226-strength-subtext-cde4@gregkh>
 <35ff23a2-d8bf-4f8b-a33f-b57ee36a81f8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff23a2-d8bf-4f8b-a33f-b57ee36a81f8@amd.com>

On Mon, Jul 22, 2024 at 10:57:46AM +0530, Gupta, Nipun wrote:
> 
> 
> On 7/22/2024 10:16 AM, Greg KH wrote:
> > On Mon, Jul 22, 2024 at 09:59:27AM +0530, Gupta, Nipun wrote:
> > > On 7/22/2024 4:17 AM, Dr. David Alan Gilbert wrote:
> > > > * Gupta, Nipun (nipun.gupta@amd.com) wrote:
> > > > > 
> > > > > 
> > > > > On 5/31/2024 5:04 AM, linux@treblig.org wrote:
> > > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > > 
> > > > > > 'cdx_mcdi_copy_buffer' has been unused since the original
> > > > > > commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
> > > > > > interaction").
> > > > > > 
> > > > > > Looking at lkml,  it was used in the V1 posting but was removed
> > > > > > somewhere before V6.
> > > > > > 
> > > > > > Remove it.
> > > > > > 
> > > > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > > > Acked-by: Nipun Gupta <nipun.gupta@amd.com>
> > > > 
> > > > Hi Nipun,
> > > >     Do you know who would pick this one up? I don't think it's made it's
> > > > way into -next yet.
> > > 
> > > Added Greg k-h for this.
> > 
> > For what?  Sorry, I have no context here...
> 
> This patch is from David to remove an unused structure in CDX. He is asking
> me that who will pick this up to be added in linux code. So I just added you
> explicitly, as you will be adding it in the your branch which will go in
> linux-next :)

Sorry, please wait for -rc1 to come out, it's the middle of the merge
window right now and I can't do anything new until then.

thanks,

greg k-h

