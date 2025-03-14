Return-Path: <linux-kernel+bounces-561366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA40A61080
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AA19C2287
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5B1FE466;
	Fri, 14 Mar 2025 11:57:51 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888061FCFFC;
	Fri, 14 Mar 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953471; cv=none; b=nY8Z4xYpBD9bT+mxxc9m8Fs2IfOHLd86dLxib+DRhcnvZNxIvaGdB0tH9Eg6rHLXZwOZ/DFuaVm6iH1P9oWpwG6wCJGhTSl+sXe3E4PhQQzsdqdSinx5B3gqzlMyLMdMebHgfAjPXapi44nV03wowdWdaWBP0iCrUAstOq0FOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953471; c=relaxed/simple;
	bh=UfCfTas+IK7+xkJrASy6gnygHRZDQSaRR3jZQ2Q8c68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ny6HiZo5YBcJjDl03IDEd3MQV+ACvnRdyMhv7GVB6aHKNsBOcAHvD+ncLLhjJm/j4TBIYllrPNa5xgfNEqvae0BsaqA8TcAjyW+qLENBkF10cO9rV6GCtQK1VWd2w2a0LPh9HKocY0dp1fl9s/5hcRa6o1w9hFFlaL9sKbCobAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.19] (51b6855d.dsl.pool.telekom.hu [::ffff:81.182.133.93])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000087004.0000000067D41888.0002BE31; Fri, 14 Mar 2025 12:52:40 +0100
Message-ID: <f581c3d25a270801de35b7d0380cbd13c4c4a131.camel@irl.hu>
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  =?UTF-8?Q?Ga=C5=A1per?= Nemgar <gasper.nemgar@gmail.com>
Cc: linux-kernel@vger.kernel.org,
  "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Date: Fri, 14 Mar 2025 12:52:39 +0100
In-Reply-To: <4f1d9817-60b1-433d-b7a8-f37057e0980a@canonical.com>
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
	 <4f1d9817-60b1-433d-b7a8-f37057e0980a@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ga=C5=A1per,

On 3/13/25 23:17, Ga=C5=A1per Nemgar wrote:
>  	/* Specific to some newer models */
>  	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +	/*Star- (User Asignable Key)*/

Asignable -> Assignable?
Could you please add a space before/after the body of the comment?

> +	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },

Other Ideapads map this star key to KEY_FAVORITES, for consistency I
think it would be better if this one mapped there too.

Thanks,
Gergo



