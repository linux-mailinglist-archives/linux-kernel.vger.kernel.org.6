Return-Path: <linux-kernel+bounces-517604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8FA382FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08AA1893259
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E621A43D;
	Mon, 17 Feb 2025 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNqPa/Yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43F217F5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795251; cv=none; b=Z9sRH5/MxCtdcPjXZAV5/MTv9siohmHtPweymON6mW56E1cvUedoV7iwtCt73ZKg4pcucbRtm7UPntDtB1OE6eHrgZh3ZjiE56AWSzkM39Z0E9meS1LMzSebG9HO86ePqPtbeyW++TAp4aAp8GGnbtl8tUzP7s2vVqO711aggn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795251; c=relaxed/simple;
	bh=MIwYUtXnjoepjUfjvLW564dXH5Zc3Mu+jVREsCj6b3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oms8TWdkPX6JxLRk04OuXzz31DrKCzjlBvOctDq6oTNCHEjhFEjpzHlJ+NAzyxC2b9ZyY1KhrKEQVc7nbrC+yOEeJVSbll9QuChL6k826umd9P4wjyaxX3kJdK6Y4wupU+SBLPRdISRvFRsaYxwrmDoqwy5aSzu4Xi/4FF8ZNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNqPa/Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408DEC4CED1;
	Mon, 17 Feb 2025 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795251;
	bh=MIwYUtXnjoepjUfjvLW564dXH5Zc3Mu+jVREsCj6b3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNqPa/Yk+KlWdNEOwwuagNYFcRU8YiLAo+jDc5w/rEo1470xncMv4DECtOyNVNPUL
	 dkRRmnnAV2vfOgukrS55kqH34XHuw/kSc+NO02ST2KoWC95XCMstzP0Zc2GD8YTcsL
	 7oYPf3AbkecKDt8uNnBP5bWibYc5wjsoJ3cR0M/tvGtKKFHkz7hvZW/yeikwd9Vl9r
	 I8rkT+/q18cKYX/EZlQXqrCmHpHSeGqokZHlDkR/XI6/JHYXb4JxOuK+yKIcs/hjbt
	 jm1aMnIbkeGXUSfbnZXCApDPk85lWCAJYWF0viD+8XDOU7l3ZlswK+fsmSWHz/c2z6
	 9RW/7oBkQLcUw==
Date: Mon, 17 Feb 2025 13:27:25 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Remove myself
Message-ID: <Z7MrLUlSzS_I3YPK@cassiopeiae>
References: <20250215073753.1217002-1-kherbst@redhat.com>
 <20250215073753.1217002-2-kherbst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215073753.1217002-2-kherbst@redhat.com>

On Sat, Feb 15, 2025 at 08:37:53AM +0100, Karol Herbst wrote:
> I was pondering with myself for a while if I should just make it official
> that I'm not really involved in the kernel community anymore, neither as a
> reviewer, nor as a maintainer.
> 
> Most of the time I simply excused myself with "if something urgent comes
> up, I can chime in and help out". Lyude and Danilo are doing a wonderful
> job and I've put all my trust into them.
> 
> However, there is one thing I can't stand and it's hurting me the most.
> I'm convinced, no, my core believe is, that inclusivity and respect,
> working with others as equals, no power plays involved, is how we should
> work together within the Free and Open Source community.
> 
> I can understand maintainers needing to learn, being concerned on
> technical points. Everybody deserves the time to understand and learn. It
> is my true belief that most people are capable of change eventually. I
> truly believe this community can change from within, however this doesn't
> mean it's going to be a smooth process.
> 
> The moment I made up my mind about this was reading the following words
> written by a maintainer within the kernel community:
> 
> 	"we are the thin blue line"
> 
> This isn't okay. This isn't creating an inclusive environment. This isn't
> okay with the current political situation especially in the US. A
> maintainer speaking those words can't be kept. No matter how important
> or critical or relevant they are. They need to be removed until they
> learn. Learn what those words mean for a lot of marginalized people. Learn
> about what horrors it evokes in their minds.
> 
> I can't in good faith remain to be part of a project and its community
> where those words are tolerated. Those words are not technical, they are
> a political statement. Even if unintentionally, such words carry power,
> they carry meanings one needs to be aware of. They do cause an immense
> amount of harm.
> 
> I wish the best of luck for everybody to continue to try to work from
> within. You got my full support and I won't hold it against anybody trying
> to improve the community, it's a thankless job, it's a lot of work. People
> will continue to burn out.
> 
> I got burned out enough by myself caring about the bits I maintained, but
> eventually I had to realize my limits. The obligation I felt was eating me
> from inside. It stopped being fun at some point and I reached a point
> where I simply couldn't continue the work I was so motivated doing as I've
> did in the early days.
> 
> Please respect my wishes and put this statement as is into the tree.
> Leaving anything out destroys its entire meaning.
> 
> Respectfully
> 
> Karol
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>

@Steven, @Masami: Can I get an ACK for taking this through the drm-misc tree?

(Not cutting any context, since you have not been copied on this one.)

- Danilo

> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353de..ca31e57fa203c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7431,7 +7431,6 @@ F:	Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
>  F:	drivers/gpu/drm/panel/panel-novatek-nt36672a.c
>  
>  DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS
> -M:	Karol Herbst <kherbst@redhat.com>
>  M:	Lyude Paul <lyude@redhat.com>
>  M:	Danilo Krummrich <dakr@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
> @@ -24062,7 +24061,6 @@ F:	tools/testing/selftests/ftrace/
>  TRACING MMIO ACCESSES (MMIOTRACE)
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> -R:	Karol Herbst <karolherbst@gmail.com>
>  R:	Pekka Paalanen <ppaalanen@gmail.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	nouveau@lists.freedesktop.org
> -- 
> 2.48.1
> 

