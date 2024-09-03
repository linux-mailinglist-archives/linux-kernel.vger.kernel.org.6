Return-Path: <linux-kernel+bounces-311998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BBB9690B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21032830DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7A4A06;
	Tue,  3 Sep 2024 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="PgJfziKW";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="M58SKnn8"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65EA20
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324450; cv=none; b=SzKixytymrmBoJjPpCU3hTRFRQ0pQk2EW7uR79ksIAOQnAEhDArebEP3ea6iTxJxrZ93l/SbwMdBptjE8fYlYkDVCgjbvmTMrvKRe3jNUCRPTFqW+8LrZCenrJraXhmJBMnqCcw/ANKiLgp8F2YKmXvxhOUPayJN4lYJwWz7yfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324450; c=relaxed/simple;
	bh=0O/A4lCVXJDxmFbAgjL24Xb2vjqQhEJrhcsb++kedbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gphMHHCNYtCb7QnIFQSkoY/YMbQ95vitKGFJD7+ya1UJa0IyPHz1cXjOhNsetG9iZmfgDIrX4XOBhXJu+v0P6iYSOzb/8Y9M1iI+HXPTwhjGbApxLl/n8JKj6+PR78EeNo4OgbPLD3C0bXJYMDky4YN+F2PX2QrsTEKym6UZMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=PgJfziKW; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=M58SKnn8; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1725324442;
	bh=0O/A4lCVXJDxmFbAgjL24Xb2vjqQhEJrhcsb++kedbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgJfziKWlFdQiAVQ730ZvLBQRdHmSvnW1kjSLf6jvA3EfTDvj1ZYm8ILu2co4QYAm
	 Pw4T9rJkfdRlQo9Kn6nIM+liOx6Qr35l0V2bOsssp6MU0ZXDca/F1WpWam7vuXiPcO
	 ab/QHjdTjTciHWCjWtNOuwtdUZknTDqt/jRX+PuImM/T/CoQiZ0De6T0v0qQeHHUQn
	 Ff4hlD1Vv/UggmflAnKN51VcyRbsAR6/Wwd+6f0JCiE6/351q6kFeWphhDqmaKwhfG
	 fvDAONjan2ETi+iVl4Ieo5ELVh/qW8DU4EmdVU9jIN42ylnEuPDv3thC1M0XWIog6n
	 k+iPXC0L4M1fA==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 48A0E2FB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:47:22 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=M58SKnn8;
	dkim-atps=neutral
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E93D9A8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:47:20 +0900 (JST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3de10cb25a9so5565170b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725324439; x=1725929239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7ARnFjZylRZ2oKJUg9WtJng/LRGDqMKM1oE5U4mL+c=;
        b=M58SKnn8iyYdTBctRcb6QnFNWHPWuuomEV/NxjpNvnav9yIZCIIFlfKRIW3x7xJ80f
         YUSJ9dRyEo/jbQWNaB3hZTNFH7RnRFPUN3Qg5Qdew5WGnr0lERktzCuvLz6cSD5laGSV
         j3uLomqfaVtpkqQO8313LuhhIisjq3iWePzMiC4kkK06YC6VvziAdqoKPdmhYNqNcCMR
         EezZNFnHlNK0MV6Xh8WuruJk7NrE5NJtldC8XOb30IAUTgPCm8bzE1eAAMvorOEBupkX
         zaL3klOMSOZ6FWBikQw403Kpi2/RAjsaMRhAp38C97cVZakhX1HumXQT7lCLAad8lTCH
         +48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725324439; x=1725929239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7ARnFjZylRZ2oKJUg9WtJng/LRGDqMKM1oE5U4mL+c=;
        b=o4i9xfKbBSU79fipbtEVrX5OBMgQtHNjkJgARzzKQi10DjTey5a8C/qnbHfJTrBW2E
         jk5tKN4j8LtY+gdvueQAkB8Ce6zry5xG+oTutJLujra01V7GQ/HJMQ4wxtdlE3flhb29
         bnbSgdgH8FMGOTT+XLaDCH61FsIQOrb7EzehQFR86r2j+F+eSNyZNUJ4bVI25YK0vqQ6
         X/x4zN8jTZUm6saXnJjw4bzWCH1+4SXL9a4eghjiMUeXYyyfSSfLhNY2l43o8ymBklAy
         8ly9AbbURowkRDVb33+yjJ3LFi1kAgZ2WtIPkUuDGU8SF5rkv+mC+vPn3GfdG8P6ahQz
         tuwg==
X-Forwarded-Encrypted: i=1; AJvYcCW8v/zdypzbhS50BNlkiB7ZkPRIc8UkMFVlKgfZ+ctZbKNi+lujpdp98mD4FiQquqLQNpv9Huf/s1Xo/BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW94TtMDnJCD6MJvymWfwSEX7jD+a3eV8HmcVKhZ961JVevHii
	yUMrUUYBygaPH2xIwTI6cUOGe37t0MMGIF6WJiNEZxIU97xSr+ixjlTRNP53RJl99q1V1WN8lco
	lX03+RjWGqFsDm8HgQs/OGSvM76EdFXQThJJRuwvUvGzvKLky34rskGo5jxjS3Ec=
X-Received: by 2002:a05:6808:1147:b0:3d9:384a:3674 with SMTP id 5614622812f47-3df22d0794bmr9595453b6e.33.1725324439658;
        Mon, 02 Sep 2024 17:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB6Sde9zsaMe0tMPPO5JTt+xM/npdn6qChe52GLMN/HnLv/unqRL5WZ3snt4wDRUuJHaPG2w==
X-Received: by 2002:a05:6808:1147:b0:3d9:384a:3674 with SMTP id 5614622812f47-3df22d0794bmr9595434b6e.33.1725324439361;
        Mon, 02 Sep 2024 17:47:19 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77451dsm8149770a12.25.2024.09.02.17.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2024 17:47:18 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1slHhU-003N1Z-3C;
	Tue, 03 Sep 2024 09:47:17 +0900
Date: Tue, 3 Sep 2024 09:47:06 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [RFC V3 3/3] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
Message-ID: <ZtZcit7HVzzedgdk@atmark-techno.com>
References: <20240830032442.226031-1-aford173@gmail.com>
 <20240830032442.226031-3-aford173@gmail.com>
 <ZtFfBs4HEShmJKsi@atmark-techno.com>
 <CAHCN7xJL-aS+kFp2YwtSSUUMoTBqZCsXb0qvCpYQGpJVM_qJYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xJL-aS+kFp2YwtSSUUMoTBqZCsXb0qvCpYQGpJVM_qJYg@mail.gmail.com>

Adam Ford wrote on Mon, Sep 02, 2024 at 04:20:11PM -0500:
> > -       const struct phy_config *cur_cfg;
> > +       struct phy_config cur_cfg;
> 
> Wouldn't converting this from a pointer require me to do a memcpy
> later?  It seems like that's more work than just pointing it to an
> address.
> 
> > -       phy->cur_cfg = &phy_pll_cfg[i];
> > +       phy->cur_cfg = phy_pll_cfg[i];
> 
> I think this is would have to be a memcpy instead of just an equal
> statement since phy->cur_cfg  would no longer be a pointer.

C allows copying structs like this, it's fine to write it as just an
equal.
It's not 100% equivalent, iiuc simple assignment is undefined behaviour
if the elements aren't aligned but memcpy will work even in that case,
but for us this is not a proble mand the generated code should be
identical... Also note I'm only suggesting that because the struct is
tiny (1*u32+7*u8 is less than two u64), but this code isn't meant to run
very often anyway so we should prioritize readability -- if you think
it's harder to understand than an extra pointer somewhere I have no
strong opinion; as said in the previous mail if parallel uses are
possible it'd be better kept on the stack anyway...

-- 
Dominique



