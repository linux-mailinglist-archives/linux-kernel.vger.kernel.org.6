Return-Path: <linux-kernel+bounces-519726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4BA3A11A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CCA3ABB37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD526BD91;
	Tue, 18 Feb 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZmul7de"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14826B974
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892273; cv=none; b=Rvgpg4c61L+FG9TDyLHd+z0yqGvDnAX6r1vaz9Qtwy7mD6sXYkBF+wZMCJ4QOi1PrqRCQLhsMmzFxFHRM1AvumcekK3TH231w4dlYIjxTpXBv72Qg+Ut3e6wEB2C3PeeSwcUyCqxDrstL1JJgfjpmf/I7fRmCj3yPBxdk5NUiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892273; c=relaxed/simple;
	bh=4o3xQjcTRMSdLkJZQtX4veKwgNtgmqGbJzelh9aDvdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JRSe124y8y4S6RbLkUR3xtvTR4r/wBPuPhz745blPn2SKZxnGzsRpGLCIg3yOp9WOgv4F8pl0EuvSur1kVBBZFNSuqRbADsuMhM7PoktHQpANaCu/fv//kiKkTr2CBHFSaaZlaVGLsLi0zx3LDnD1BwJrJJOdKjKPp9SRiC6pKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZmul7de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D44FC4CEE2;
	Tue, 18 Feb 2025 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739892272;
	bh=4o3xQjcTRMSdLkJZQtX4veKwgNtgmqGbJzelh9aDvdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZmul7deNORGQ242ExBuaihdpiMsHeI0A9TyyhHs7Nb05CUzmLtNrhcirO7jDg9A4
	 703YuyShdLoQ7kNIXt7jslkZmmYIleYRXG9LX65zCkJ0807fw1chTXfKnOlSoaOhHO
	 rpdLucQg2WYKeva+E/iGLYxqGr/AU6a46tp4KzpHar5qq8d4/rxRAMPCAX6mC7q0xs
	 7Kur7Uvi26vTvaq7pEec/s2h1WLC6lKaMGpsDDG3KW/cGa6dXp4rmeaWlPDv2vwzrW
	 bWPv7l/7y97xXd1tfTJ7PB9XbmLrOcPR1bfD1j1C8J8mg48CJ3bv2TKnJupj0UyNGl
	 bgfz8zVD7x5kg==
Date: Wed, 19 Feb 2025 00:24:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, Dave Airlie
 <airlied@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Karol Herbst
 <kherbst@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove myself
Message-Id: <20250219002428.1c493839dd402181bf888065@kernel.org>
In-Reply-To: <Z7MrLUlSzS_I3YPK@cassiopeiae>
References: <20250215073753.1217002-1-kherbst@redhat.com>
	<20250215073753.1217002-2-kherbst@redhat.com>
	<Z7MrLUlSzS_I3YPK@cassiopeiae>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 13:27:25 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> On Sat, Feb 15, 2025 at 08:37:53AM +0100, Karol Herbst wrote:
> > I was pondering with myself for a while if I should just make it official
> > that I'm not really involved in the kernel community anymore, neither as a
> > reviewer, nor as a maintainer.
> > 
> > Most of the time I simply excused myself with "if something urgent comes
> > up, I can chime in and help out". Lyude and Danilo are doing a wonderful
> > job and I've put all my trust into them.
> > 
> > However, there is one thing I can't stand and it's hurting me the most.
> > I'm convinced, no, my core believe is, that inclusivity and respect,
> > working with others as equals, no power plays involved, is how we should
> > work together within the Free and Open Source community.
> > 
> > I can understand maintainers needing to learn, being concerned on
> > technical points. Everybody deserves the time to understand and learn. It
> > is my true belief that most people are capable of change eventually. I
> > truly believe this community can change from within, however this doesn't
> > mean it's going to be a smooth process.
> > 
> > The moment I made up my mind about this was reading the following words
> > written by a maintainer within the kernel community:
> > 
> > 	"we are the thin blue line"
> > 
> > This isn't okay. This isn't creating an inclusive environment. This isn't
> > okay with the current political situation especially in the US. A
> > maintainer speaking those words can't be kept. No matter how important
> > or critical or relevant they are. They need to be removed until they
> > learn. Learn what those words mean for a lot of marginalized people. Learn
> > about what horrors it evokes in their minds.
> > 
> > I can't in good faith remain to be part of a project and its community
> > where those words are tolerated. Those words are not technical, they are
> > a political statement. Even if unintentionally, such words carry power,
> > they carry meanings one needs to be aware of. They do cause an immense
> > amount of harm.
> > 
> > I wish the best of luck for everybody to continue to try to work from
> > within. You got my full support and I won't hold it against anybody trying
> > to improve the community, it's a thankless job, it's a lot of work. People
> > will continue to burn out.
> > 
> > I got burned out enough by myself caring about the bits I maintained, but
> > eventually I had to realize my limits. The obligation I felt was eating me
> > from inside. It stopped being fun at some point and I reached a point
> > where I simply couldn't continue the work I was so motivated doing as I've
> > did in the early days.
> > 
> > Please respect my wishes and put this statement as is into the tree.
> > Leaving anything out destroys its entire meaning.
> > 
> > Respectfully
> > 
> > Karol
> > 
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> 
> @Steven, @Masami: Can I get an ACK for taking this through the drm-misc tree?
> 
> (Not cutting any context, since you have not been copied on this one.)

OK,

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

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
> > -- 
> > 2.48.1
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

