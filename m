Return-Path: <linux-kernel+bounces-425045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D623C9DBCD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7292BB21848
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCC51C07CE;
	Thu, 28 Nov 2024 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="sZ02NTL0"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56341C94
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825005; cv=none; b=oFz8eiAW36NBr0eYmGhJqwym7UKY58UoK3+HOMlVQ03advez0sSer00cNEoG0VofMuWWclT+DTB2W2mTFHEWp7wCtvg3aHaurFkLw2EWCcZT+PLGvFKM0kk5asmN2ahLfE4x9xTKUpUtMgZUBgNOM22EPJhwKd9cCJdrSauB+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825005; c=relaxed/simple;
	bh=8OD8GHhVEdx8Vl4kLFBCTKXUOVgX6ynGO/9u9I1r3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQpQ9yL8W8kSxp5Ac/M6YmzCC02wrHpQ1XZyDGjhSNNa173SGo2ZOBnbnD/nDowc/JF3FLruQ0vQ1osA1oZzk9rhodR6OUMh1qoonJxvkykj0AaOu7gl/ioK4PYwxePz/4ai1c1XPjaHkNTQOmOfi+XNnQFygf46499kcJ6tKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=sZ02NTL0; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 2D2321770BE; Thu, 28 Nov 2024 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1732824996; bh=8OD8GHhVEdx8Vl4kLFBCTKXUOVgX6ynGO/9u9I1r3wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZ02NTL0pIvXvEVSggMnke5jM4HGgGmWWZiYds8C5l2LEX4R0Clx9m3zn7/kD4n10
	 Zm+2a0PO/pCzdOq9RFFDoZGyVMct7ve2KgASMIDc49fDbC5Xs71nYe0Q04E6QdMxmi
	 eNbRnhvdYR4YUPRslmMjw1jYvyEnct8snpxLBp50Fh1Xa8SivY6hdhjxAfbeCFyaBI
	 Wc9h0yRZnTl6lmh2eUBHivA6UmdgeCP6RpQYeF43+lNmMcUD8Q0kfb+B+rvwcF7o8P
	 V7I707gBOvs6EP6Wvbp1KbeDx4hBGCmoU05PinSTp28PnRY/UvrGqcGSuaD++bqdLk
	 /3r0TwHsYsnsw==
Date: Thu, 28 Nov 2024 20:16:36 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, danielt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: utilize more readable control characters macro in
 kdb io
Message-ID: <20241128201636.GA370101@lichtman.org>
References: <20241121204527.GA285791@lichtman.org>
 <CAD=FV=V6B9mAb-EQaK1K+pa4duzOGmz=dt4QUFVVGUbq7NnK3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V6B9mAb-EQaK1K+pa4duzOGmz=dt4QUFVVGUbq7NnK3Q@mail.gmail.com>

On Wed, Nov 27, 2024 at 12:55:10PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 21, 2024 at 12:45 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > @@ -267,7 +267,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
> >         if (key != 9)
> 
> FWIW, the "9" above is better as CTRL_KEY('I').

Right, missed that will fix.

> 
> 
> > @@ -176,14 +174,16 @@ int kdb_get_kbd_char(void)
> >         case KT_LATIN:
> >                 switch (keychar) {
> >                 /* non-printable supported control characters */
> > -               case CTRL('A'): /* Home */
> > -               case CTRL('B'): /* Left */
> > -               case CTRL('D'): /* Del */
> > -               case CTRL('E'): /* End */
> > -               case CTRL('F'): /* Right */
> > -               case CTRL('I'): /* Tab */
> > -               case CTRL('N'): /* Down */
> > -               case CTRL('P'): /* Up */
> > +               case CTRL_KEY('A'): /* Home */
> > +               case CTRL_KEY('B'): /* Left */
> > +               case CTRL_KEY('D'): /* Del */
> > +               case CTRL_KEY('E'): /* End */
> > +               case CTRL_KEY('F'): /* Right */
> > +               case CTRL_KEY('I'): /* Tab */
> > +               case CTRL_KEY('K'):
> > +               case CTRL_KEY('N'): /* Down */
> > +               case CTRL_KEY('P'): /* Up */
> > +               case CTRL_KEY('U'):
> 
> You snuck in a functionality change (adding Ctrl-K and Ctrl-U) here
> that should be in a separate patch.
> 

Oops, those are left overs of something else I was trying to do, will remove.

> Otherwise this looks nice to me.

Thanks! Will send out a v2 with fixes shortly,
Nir

