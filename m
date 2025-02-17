Return-Path: <linux-kernel+bounces-518167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E017A38AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C6C1891790
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3822B8CB;
	Mon, 17 Feb 2025 17:43:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111B224AF6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814232; cv=none; b=j7cJm2pUtWE3H0ONfwAWX+ibPtv7t1xliJNJdyBQpY4ByNnwXqclBAbU7xFCTJwzQvToW53koYcHgWoj1Cl8TH/m05l+laIkvo6GWRWTW6ZVtuF06Y7aNoZUaQsHIzgM9sC8Wo2LbPtfNkJra66OSn8Yd6ZKzwa2OHypdJo4SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814232; c=relaxed/simple;
	bh=Iyw3rLszYwkIAf/hHHG92mVPOssacfCMtfBFCy0PC4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qznNHDRJBNRfc+rctfDtqBtWwd6GqB++u+fqmKAsjfFAFhWh0v1mDBfhkOTkeJ64nvvOwSazhEBnyfNj2juww1SXL9StahqFoX2oyAkAxYl3t10AvuUkt7f2A6upFtUfzQOzQKP8PMM/9yfONqC9w3jFjHPXIiFkDpXO8rAB86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E76C4CED1;
	Mon, 17 Feb 2025 17:43:50 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:44:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Dave Airlie
 <airlied@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Karol Herbst
 <kherbst@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove myself
Message-ID: <20250217124410.72a67bf8@gandalf.local.home>
In-Reply-To: <Z7MrLUlSzS_I3YPK@cassiopeiae>
References: <20250215073753.1217002-1-kherbst@redhat.com>
	<20250215073753.1217002-2-kherbst@redhat.com>
	<Z7MrLUlSzS_I3YPK@cassiopeiae>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 13:27:25 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> > Signed-off-by: Karol Herbst <kherbst@redhat.com>  
> 
> @Steven, @Masami: Can I get an ACK for taking this through the drm-misc tree?
> 
> (Not cutting any context, since you have not been copied on this one.)

Sure,

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> - Danilo
> 
> > ---
> >  MAINTAINERS | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 25c86f47353de..ca31e57fa203c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7431,7 +7431,6 @@ F:	Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> >  F:	drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> >  
> >  DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
> > -M:	Karol Herbst <kherbst@redhat.com>
> >  M:	Lyude Paul <lyude@redhat.com>
> >  M:	Danilo Krummrich <dakr@kernel.org>
> >  L:	dri-devel@lists.freedesktop.org
> > @@ -24062,7 +24061,6 @@ F:	tools/testing/selftests/ftrace/
> >  TRACING MMIO ACCESSES (MMIOTRACE)
> >  M:	Steven Rostedt <rostedt@goodmis.org>
> >  M:	Masami Hiramatsu <mhiramat@kernel.org>
> > -R:	Karol Herbst <karolherbst@gmail.com>
> >  R:	Pekka Paalanen <ppaalanen@gmail.com>
> >  L:	linux-kernel@vger.kernel.org
> >  L:	nouveau@lists.freedesktop.org

