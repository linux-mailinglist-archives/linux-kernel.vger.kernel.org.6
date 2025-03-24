Return-Path: <linux-kernel+bounces-573914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C53FA6DDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056B33AB542
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B61261370;
	Mon, 24 Mar 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g0daaQYd"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A49261367
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829290; cv=none; b=mjKtTyO9fVXwG+Ctyw7SobxMbjNz8wwaeuzNfjLnW3xX0HKURWGGHbJO5bt9I5AWH0w6hMTq0f3l/loCIskfCkmfbrNb0j5i+QTutScMPN2uO+xvIs8HLHwutoPt18nOFcHosXATiAp4mG8JUNSvn3XjRGrFOcjcxh8Kqm3BrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829290; c=relaxed/simple;
	bh=j7WD5agwJn5RbucIl+SimdBcPkopv0JXyLkpma4n+Tw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hzofuLDMce64MsM9T6E5LOkln4CcIKTiINRr33qisxCX8lB8wr/AgUwoPpMoFf6LUxAqhdJjy0uouBQYcGqyGzdNuMmMU6gxf3lr4ExOGQRf3g5BvvXcGFWvlNUHZ2RnHfDwHZaNNPdicUG5ZULBxqVYIOhxiWqz/pjLuqK2GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g0daaQYd; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79AA641C84;
	Mon, 24 Mar 2025 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742829286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6zaM60hzrVOKBGboadVOUeo4rs8w8+hN/T1bSMjRwtE=;
	b=g0daaQYdVhvmoMMrjPKZ1/Q9ju1cE/JJDEDFLw0qmpYF0fJc00DnUt8SekLIDr7/wH/DTq
	JFxyXMW8Y0GNG90HmLgL/HKlWm55A1eHzCWVoffgwvyPrdWeyyi6k5LP4InGZjfm/Zq0NR
	B+GBGJ2MraV1PVTuX+O+0Uv/7Bfd5RG+OMmC7s/P782vB/eQ5F80Y7us06L9bmYw/5l3zc
	brrMuXt0DzqdtJ7TUIrjnGA73DZEnZE6CP9ZpduVrUbwjA6vzIByIRgcmCvzf5H+c9XSof
	BJON5CpkLtMja8VBK1MxH1WyNJnExhudF3UUB9Q0dDHUthYD4sPGp4GfVumKBA==
Message-ID: <bffd185c-6d27-47b8-8388-936da0c0e67f@bootlin.com>
Date: Mon, 24 Mar 2025 16:14:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 15/59] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com
References: <20250320185238.447458-1-jim.cromie@gmail.com>
 <20250320185238.447458-16-jim.cromie@gmail.com>
Content-Language: en-US
Autocrypt: addr=louis.chauvet@bootlin.com; keydata=
 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
In-Reply-To: <20250320185238.447458-16-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetfffhtdeigfehffduuedvkeefgfdvuddugfffteetffdvteffgfejvedugffgffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvtdgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepjhhimhdrtghrohhmihgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsr
 dhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepihhnthgvlhdqghhvthdquggvvheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehinhhtvghlqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepihhnthgvlhdqghhfgidqthhrhigsohhtsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 20/03/2025 à 19:51, Jim Cromie a écrit :
> The body of ddebug_attach_module_classes() is dominated by a
> code-block that finds the contiguous subrange of classmaps matching on
> modname, and saves it into the ddebug_table's info record.
> 
> Implement this block in a macro to accommodate different component
> vectors in the "box" (as named in the for_subvec macro).
> 
> And hoist its invocation out of ddebug_attach_module_classes() up into
> ddebug_add_module().  This moves the filtering step up closer to
> dynamic_debug_init(), which effectively does the same for builtin
> pr_debug descriptors; segmenting them into subranges by modname.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
  >
> ---
>   lib/dynamic_debug.c | 57 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index f7ec2365ab40..192783ff7b98 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -1242,30 +1242,34 @@ static const struct proc_ops proc_fops = {
>   
>   static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
>   {
> -	struct ddebug_class_map *cm;
> -	int i, nc = 0;
> -
> -	/*
> -	 * Find this module's classmaps in a subrange/wholerange of
> -	 * the builtin/modular classmap vector/section.  Save the start
> -	 * and length of the subrange at its edges.
> -	 */
> -	for_subvec(i, cm, di, maps) {
> -		if (!strcmp(cm->mod_name, dt->mod_name)) {
> -			if (!nc) {
> -				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
> -					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
> -				dt->info.maps.start = cm;
> -			}
> -			nc++;
> -		}
> -	}
> -	if (nc) {
> -		dt->info.maps.len = nc;
> -		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> -	}
> +	vpr_info("module:%s attached %d classes\n", dt->mod_name, dt->info.maps.len);
>   }
>   
> +/*
> + * scan the named array: @_vec, ref'd from inside @_box, for the
> + * start,len of the sub-array of elements matching on ->mod_name;
> + * remember them in _dst.  Macro depends upon the fields being in both
> + * _box and _dst.
> + * @_i:   caller provided counter var, init'd by macro
> + * @_sp:  cursor into @_vec.
> + * @_box: ptr to a struct with @_vec, num__##@_vec, mod_name fields.
> + * @_vec: name of ref into array[T] of builtin/modular __section data.
> + * @_dst: ptr to struct with @_vec and num__##@_vec fields, both updated.

I think you forgot to update this documentation with the new vector 
structure (num__##@_vec does not exists anymore)

> + */
> +#define dd_mark_vector_subrange(_i, _dst, _sp, _box, _vec) ({	\
> +	int nc = 0;							\
> +	for_subvec(_i, _sp, _box, _vec) {				\
> +		if (!strcmp((_sp)->mod_name, (_dst)->mod_name)) {	\
> +			if (!nc++)					\
> +				(_dst)->info._vec.start = (_sp);	\
> +		} else {						\
> +			if (nc)						\
> +				break; /* end of consecutive matches */ \
> +		}							\
> +	}								\
> +	(_dst)->info._vec.len = nc;					\
> +})
> +
>   /*
>    * Allocate a new ddebug_table for the given module
>    * and add it to the global list.
> @@ -1273,6 +1277,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
>   static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
>   {
>   	struct ddebug_table *dt;
> +	struct ddebug_class_map *cm;
> +	int i;
>   
>   	if (!di->descs.len)
>   		return 0;
> @@ -1294,6 +1300,13 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
>   	dt->info = *di;
>   
>   	INIT_LIST_HEAD(&dt->link);
> +	/*
> +	 * for builtin modules, ddebug_init() insures that the di
> +	 * cursor marks just the module's descriptors, but it doesn't
> +	 * do so for the builtin class _maps & _users.  find the

Nitpick, the _users builtin class is only introduced in patch 19/56, 
maybe update the documentation there.

> +	 * start,len of the vectors by mod_name, save to dt.
> +	 */
> +	dd_mark_vector_subrange(i, dt, cm, di, maps);
>   
>   	if (di->maps.len)
>   		ddebug_attach_module_classes(dt, di);

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



