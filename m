Return-Path: <linux-kernel+bounces-278127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEE94AC60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93C61F24CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84930823DE;
	Wed,  7 Aug 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rYBtNKuO"
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8018289E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043666; cv=none; b=b+dfx8gBDOgjRDa+EkbwhgOiFrHbFY2pfIqqKDAVlNMFxaBZ3OBxP//BdNGyrBQZstt8emeST/IJotlC0wnnIJc58EGYx2BDolovsdixChwRhz7SSOQtzvAYGUQ356c2lBTvIN2R7RuVo86tPIzITEBDHdqYc2a/zNeUXo7yDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043666; c=relaxed/simple;
	bh=7Tp7ucPRBB+fxNVCk+S6+A1Ke54+/R0646GFqWL9qn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMZq5HI5e6rUw4H9qVmwethfVVaZWu4CVqwtIReMyy9GSpyag4BzrvQk2l+w7ixQUdR+U5jprGl/QMs51jOyTp3FAhu8LdMR9aI26QnoNYz+DJo1Ry0lLxNWBz3a9zPiXJvegC1+1AEXeODKCrcgSmfaXakwm+/LQJByzdwD6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rYBtNKuO; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WfDGw22cQzZmq;
	Wed,  7 Aug 2024 17:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1723043656;
	bh=pq3zt1F/Me0xMXRivd/QVwEg5HhWQNAo2gPJVW36cf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYBtNKuOKL0yiW00PYl6421y8XjnBnDBCEJpko4v43xJ6mQwQ9SOQTaUXLIMlmQ1P
	 OIatPJxYzx3Bf6VbZhBAPa14loezCF81H2GCBe6Cz8jQbVRIMsTL7/5rvXrh3KFT2o
	 3QZPIHdSqNDGmOOwI13T4mycAEHExensALzCujnM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WfDGv43T6zT9w;
	Wed,  7 Aug 2024 17:14:15 +0200 (CEST)
Date: Wed, 7 Aug 2024 17:14:11 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 4/4] Landlock: Document
 LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET and ABI versioning
Message-ID: <20240807.uLohy7ohYo8A@digikod.net>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <bbb4af1cb0933fea3307930a74258b8f78cba084.1722570749.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbb4af1cb0933fea3307930a74258b8f78cba084.1722570749.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 01, 2024 at 10:02:36PM -0600, Tahera Fahimi wrote:
> Introducing LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET as an IPC scoping
> mechanism in Landlock ABI version 6, and updating ruleset_attr,
> Landlock ABI version, and access rights code blocks based on that.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> v8:
> - Improving documentation by specifying differences between scoped and
>   non-scoped domains.
> - Adding review notes of version 7.
> - Update date
> v7:
> - Add "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" explanation to IPC scoping
>   section and updating ABI to version 6.
> - Adding "scoped" attribute to the Access rights section.
> - In current limitation, unnamed sockets are specified as sockets that
>   are not restricted.
> - Update date
> ---
>  Documentation/userspace-api/landlock.rst | 33 ++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 07b63aec56fa..d602567b5139 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: April 2024
> +:Date: August 2024
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -81,6 +81,8 @@ to be explicit about the denied-by-default access rights.
>          .handled_access_net =
>              LANDLOCK_ACCESS_NET_BIND_TCP |
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +        .scoped =
> +            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
>      };
>  
>  Because we may not know on which kernel version an application will be
> @@ -119,6 +121,9 @@ version, and only use the available subset of access rights:
>      case 4:
>          /* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +    case 5:
> +        /* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> +        ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
>      }
>  
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -306,6 +311,23 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
>  process, a sandboxed process should have a subset of the target process rules,
>  which means the tracee must be in a sub-domain of the tracer.
>  
> +IPC Scoping
> +-----------
> +
> +Similar to the implicit `Ptrace restrictions`_, we may want to further restrict
> +interactions between sandboxes. Each Landlock domain can be explicitly scoped
> +for a set of actions by specifying it on a ruleset. For example, if a sandboxed
> +process should not be able to :manpage:`connect(2)` to a non-sandboxed process
> +through abstract :manpage:`unix(7)` sockets, we can specify such restriction
> +with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
> +
> +A sandboxed process can connect to a non-sandboxed process when its domain is
> +not scoped. If a process's domain is scoped, it can only connect to processes in

...it can only connect to sockets created by proccesses in the same
scoped domain.

> +the same scoped domain.
> +
> +IPC scoping does not support Landlock rules, so if a domain is scoped, no rules
> +can be added to allow accessing to a resource outside of the scoped domain.
> +
>  Truncating files
>  ----------------
>  
> @@ -404,7 +426,7 @@ Access rights
>  -------------
>  
>  .. kernel-doc:: include/uapi/linux/landlock.h
> -    :identifiers: fs_access net_access
> +    :identifiers: fs_access net_access scope
>  
>  Creating a new ruleset
>  ----------------------
> @@ -541,6 +563,13 @@ earlier ABI.
>  Starting with the Landlock ABI version 5, it is possible to restrict the use of
>  :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
>  
> +Abstract Unix sockets Restriction  (ABI < 6)

Let's follow the capitalization used by man pages: "UNIX" instead of
"Unix".

> +--------------------------------------------
> +
> +With ABI version 6, it is possible to restrict connection to an abstract Unix socket
> +through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to the ``scoped`` ruleset
> +attribute.
> +
>  .. _kernel_support:
>  
>  Kernel support
> -- 
> 2.34.1
> 

