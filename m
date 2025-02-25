Return-Path: <linux-kernel+bounces-531201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A639A43D64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F53E19C3979
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3B266F0B;
	Tue, 25 Feb 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dn1Q95Pb"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB4266EF4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482532; cv=none; b=Q5erEC//cK7B1/XVwS8fWFHMEy9v20C0rNBbyyd/Gogh1rx0KrJh/eCJR1dJSEP7QglMGKly5vWTmGrld8KfKSWZriEU0hGd3gSp+KiXKktuj9IRMf/gpkvED+ZYZCIAK+Sm0u2xGT02RhQJx1eU7dVrkxMvvBM1j9ju/jdPdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482532; c=relaxed/simple;
	bh=5AtvQHmXMFhMljTtodFbJvlFGesB5SKOJRU4/VTo/Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ0Y67yrjOehLBSBz6HO9bNwxEYcOswZg9zRTqkK2bqM4HXIDol5pOnjhxKKpIngd84iRf92McDxfLOgUiWYT36byAClnGEM+4jLukOSOG9puKIa4d/WA936nQDr/BEhU3EgNn3BAK7aZiiFrHuA8AEhjTT0Q+8is4Vz0d2pJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dn1Q95Pb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C18744213;
	Tue, 25 Feb 2025 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740482528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OxoGQW/kRJUtB8Qz3VUy28/n9V0Il9+Kv1b17NZYT8=;
	b=Dn1Q95Pbzkqv0u3DJZC1rPF/NK7kyTHUrRuLJWzaaBYMw+YB4jzWVXXYOuO078iLBkZy4W
	uN8j6/mkv40RPTubFBR3XNCSzN/R14F2Zy7IY5GosJTfIqBqFpeH7P0Cfc0jw/+gJVmq03
	xAXKMx8/6PHLk6hri5GDN2G11sN/0LF/9P7TI2ZEktC7f4C09gJGH98dYmMhn8ltt59Ug9
	HOE88L1Shnfu7d8prpQe1VJtbo/kpbjCyIJOpIGWC3G5A4oKwI8KhUREIpG9bmX2Jbzeu4
	yobpqkHcHr8q1aaKDs4j5QSkJAPDUZlTPshyD7FB5mK42rUI2iuIsAAhbZa2Eg==
Date: Tue, 25 Feb 2025 12:22:05 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 02/63] test-dyndbg: fixup CLASSMAP usage error
Message-ID: <77a8fdeb-c906-4cd2-ac42-e6a5d3d9e521@bootlin.com>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>,
	linux-kernel@vger.kernel.org, jbaron@akamai.com,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	intel-gfx-trybot@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20250125064619.8305-1-jim.cromie@gmail.com>
 <20250125064619.8305-3-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125064619.8305-3-jim.cromie@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeiffduffeivdejgfejheeuudekkedvjeeuffegfefghfffkeelgffgieevudejnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohhuihhsqdgthhgruhhvvghtqdhlrghpthhophdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehjihhmrdgtrhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnr
 dhorhhgpdhrtghpthhtohepuhhkrghsiigssegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigqdhtrhihsghotheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 25/01/2025 à 07:45, Jim Cromie a écrit :
> A more careful reading of logging output from test_dynamic_debug.ko
> reveals:
> 
> lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
> lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
> lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
> lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13
> 
> 107 says: HI is unknown, 105,106 have LOW/MID and MID/HI skew.
> 
> The enum's 1st val (explicitly initialized) was wrong; it must be
> _base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
> enumeration exceeded the range of mapped class-id's, which triggered
> the "class unknown" report.  I coded in an error, intending to verify
> err detection, then forgot, and missed that it was there.
> 
> So this patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
> that it is too error-prone.  As noted in test-mod comments:
> 
>   * Using the CLASSMAP api:
>   * - classmaps must have corresponding enum
>   * - enum symbols must match/correlate with class-name strings in the map.
>   * - base must equal enum's 1st value
>   * - multiple maps must set their base to share the 0-62 class_id space !!
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
>   lib/test_dynamic_debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 77c2a669b6af..396144cf351b 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
>   DD_SYS_WRAP(disjoint_bits, T);
>   
>   /* symbolic input, independent bits */
> -enum cat_disjoint_names { LOW = 11, MID, HI };
> +enum cat_disjoint_names { LOW = 10, MID, HI };
>   DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
>   			"LOW", "MID", "HI");
>   DD_SYS_WRAP(disjoint_names, p);

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


