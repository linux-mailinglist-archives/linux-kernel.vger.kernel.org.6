Return-Path: <linux-kernel+bounces-368290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D60F9A0DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5037B24376
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4720F5A3;
	Wed, 16 Oct 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPqNsvBN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49D20E038;
	Wed, 16 Oct 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091544; cv=none; b=Hn5d6CEU87RH+vgqHtAupc1uMEVB3sjVjctKAwi4FXPqAzptshnkcrEHdVd+AZIEx9KMl84lDLhhvajdI4zOTcMcWaE6cO5LZH3L2ZymU94Arszr+CB8LODsbv6q+dcNAPFW3lPTaJcvMEynrAn89StogcWDYAYklQeMioq/lt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091544; c=relaxed/simple;
	bh=WhUvBAc7LIh6JlDAA3ScEEn3YXsU7Z6zReEaX3jqZcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1F0P5kb0Si6+4H2byZDM5r/gbozaMVA8sQSQ8IZ7Gskg2nLAR9gd6AMQRS7MovvyKAZDkmxyFkMmN/2+0yplaK1QWYq6atXefrJfbsWYBc4o/KhS/yMFjSJLG9DeO+YDJ3vOpur4w13LH7F3MFmKQ6VBBPktQb6fz1N35h04v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPqNsvBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE4C4CED1;
	Wed, 16 Oct 2024 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729091543;
	bh=WhUvBAc7LIh6JlDAA3ScEEn3YXsU7Z6zReEaX3jqZcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPqNsvBN3Yh7JIENJspTnsyy4l29MoJzbPR7t37lb6bUepc0LmUDdN7v2g5/3pm9x
	 o0cvvMsUXs2QVRZoWPwnouECcdLzBl+5iN3Iu4HGlgGeZK9rpGwWA1wu1v6iSXYB58
	 Y8Z5tAySPvqi82ExqYva3bOKhMWh/+Buy9f2uhPA=
Date: Wed, 16 Oct 2024 17:12:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Message-ID: <2024101625-activate-gluten-3547@gregkh>
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh>
 <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>

On Wed, Oct 16, 2024 at 06:54:00AM -0600, Everest K.C. wrote:
> On Wed, Oct 16, 2024 at 2:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> > > The variable `residue` is an unsigned int, also the function
> > > `fluke_get_dma_residue` returns an unsigned int. The value of
> > > an unsigned int can only be 0 at minimum.
> > > The less-than-zero comparison can never be true.
> > > Fix it by removing the dead condition in the if statement.
> > >
> > > This issue was reported by Coverity Scan.
> > > Report:
> > > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > > unsigned_compare: This less-than-zero comparison of an unsigned value
> > > is never true. residue < 0U.
> > >
> > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > > ---
> > > V1 -> V2: - Fixed typo of comparison in changelog
> > >           - Removed Fixes tag
> > >
> > >  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > index f9f149db222d..51b4f9891a34 100644
> > > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
> > >        */
> > >       usleep_range(10, 15);
> > >       residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
> > > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > > +     if (WARN_ON_ONCE(residue > length))
> >
> > No, this is incorrect, now we never notice is the call to
> > fluke_get_dma_residue() has failed.  Please fix that bug instead (hint,
> > Covertity is giving you a pointer to where something might be wrong, but
> > this change is NOT how to fix it.)
> I need a little guidance here.
> My best guess to fix the bug would be to make fluke_get_dma_residue()
> return an int instead of unsigned int or size_t. But theoretically the
> maximum value of residue can be UINT_MAX, and casting it to int will
> result in a negative number, which in turn will cause  the error check
> condition to evaluate to true.

Look at the code to see what it does.

> The best solution I see would be to make fluke_get_dma_residue() return
> an int (-1 for error and 0 for success). Then pass the address of residue
> reference to fluke_get_dma_residue() to be updated.
> Am I on the right track ?

Close, yes.  "-1" is not a valid error, so that needs to be fixed at the
least here, as it's obviously not returning an error that gets caught
today :)

good luck!

greg k-h

