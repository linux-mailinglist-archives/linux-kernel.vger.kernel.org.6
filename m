Return-Path: <linux-kernel+bounces-258457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738593881C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E6A1F2150A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA7171AA;
	Mon, 22 Jul 2024 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHcf18Ia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C3802
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721623602; cv=none; b=YeLd4+Azd2RoTu+mN7045mrNl+gMMJl4mhintd0yNUXaep7iT0+9DzptPy0bCG+HtOcMUikOD29v0Xmwetq/kdxPwx0lZBqN2V78eIZEVJzdJeRiAmLvGkd5wcV9qSOrHDP1jXq0Irr0dHVqR400BH6PRFKjuANFgCPgAnszYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721623602; c=relaxed/simple;
	bh=SlkdpWpcLX+ZiKjsD8P5uJYOIWGphak6DXdSt1uplhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqJWpbOgatLWwwMWX+qw9uROgAZLtMkSHz9ULZaAVYKkCUrV0IPtrEfTZMt/uLfjgTcR5kjpUhVGhMlfg3VQ1orcxWrm92kHcJI+t1PqmMhNP+dlLeqhXZdO28DrrYvvDbqeq2AuCxxgy/AS0XDjV9Xg//N0VXEy2EpjjoIF0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHcf18Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA918C116B1;
	Mon, 22 Jul 2024 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721623602;
	bh=SlkdpWpcLX+ZiKjsD8P5uJYOIWGphak6DXdSt1uplhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHcf18Ia2qIkCy6agaTaQys4lvvpXlLcTHZW4t98J86MscYtqdOM1KwuUrSnZ1Wzw
	 eyMKC6T98bOPfAVE/w0d0l3wjn7ZqTDBcJGvEUuwghuO3NAL8uh5a682MP5/S+vToL
	 c5GOEDIGdFYCtjup0nwNcWdb9o5iGx3MFWg68YqQ=
Date: Mon, 22 Jul 2024 06:46:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, nikhil.agarwal@amd.com,
	abhijit.gangurde@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
Message-ID: <2024072226-strength-subtext-cde4@gregkh>
References: <20240530233436.224461-1-linux@treblig.org>
 <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com>
 <Zp2QBoqAjKjABfJD@gallifrey>
 <7141e8f9-db0f-43e0-98ed-c3e2c44720d7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7141e8f9-db0f-43e0-98ed-c3e2c44720d7@amd.com>

On Mon, Jul 22, 2024 at 09:59:27AM +0530, Gupta, Nipun wrote:
> On 7/22/2024 4:17 AM, Dr. David Alan Gilbert wrote:
> > * Gupta, Nipun (nipun.gupta@amd.com) wrote:
> > > 
> > > 
> > > On 5/31/2024 5:04 AM, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > 
> > > > 'cdx_mcdi_copy_buffer' has been unused since the original
> > > > commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
> > > > interaction").
> > > > 
> > > > Looking at lkml,  it was used in the V1 posting but was removed
> > > > somewhere before V6.
> > > > 
> > > > Remove it.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > Acked-by: Nipun Gupta <nipun.gupta@amd.com>
> > 
> > Hi Nipun,
> >    Do you know who would pick this one up? I don't think it's made it's
> > way into -next yet.
> 
> Added Greg k-h for this.

For what?  Sorry, I have no context here...

