Return-Path: <linux-kernel+bounces-277236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C184949E41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8691F211A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115F17ADE2;
	Wed,  7 Aug 2024 03:21:54 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66F1DFEB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000913; cv=none; b=BNK2w5P3BNVNoj+qcZtZr33jwaDIvejLvj+Tx/xQo7J9ttuFU4b7fZEgVnRtkheUAPCyUYaIeq4+GpIcz7VE8L0I3x7FhhXemN9AdH+MIiGOHyxvSKb6CqdVku8E8kylmd3mAVHuiJheaFwlC2OI7ZcMI5BzB4/YmT/9shEXckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000913; c=relaxed/simple;
	bh=tE/y/HgqR5u3o/+rxlc2mI5vLOsYOlePoBjYyS7h7MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neTm+ppXcdvpCs+iLp4+bXBMMLm4X+NoroBfNCzBF4U2kyKQR6ACBLnWdxuVS2EajIwrx7t7pkDZDT0JuAtJTjcNDwrQ8z7JTGYlc0G+1xMJtFq5b6XmJ68nXwXqIhU5D7hdBb3/E17UUT5GzJQKG6GnyDWeXkpCqSWLYt9MnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81fda7d7a48so50937339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000911; x=1723605711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE/y/HgqR5u3o/+rxlc2mI5vLOsYOlePoBjYyS7h7MU=;
        b=lRjRgHaV6b/RAUdrlmu/xKpDvQ9IERJr+oh+DtCMl4tKnfUVNju03CxLQbEV6GzT9V
         scZD0szo5nm/y10W1sVaNiWA+/2TXQZlSxUI0CPvceReuEt/ahOr6BrXwV39j+BlJRYW
         jlo5dvzk6x84t3kITcW8zAYdgZfD4aAmXyiEXWG4utNyDJMQUmnmGtcefU1QdPkn6/Fj
         c3y4PAOHhEZdm2v6VE8H6ijGjEU5rOZZ9uTmYANDPQc2NcOVqaie8HOKlCN9wBY0EAwu
         3Ns7vmymkLEuq34yO2bAqFMkKMs4abI7j8aULqeOAVGpY8PC8BwnbkQz+Fptg95gz7ja
         scKw==
X-Forwarded-Encrypted: i=1; AJvYcCWHHGNHoRX+ePl5ZOln6N2vCYaMil2O0EdYyXczU0d7uLlno5LMSLqyOjdOZXfuDgnid55hsdZgB6YgQnq9adY93pFPzq0MO3bYhrFm
X-Gm-Message-State: AOJu0Yy2MEmsPPRUvmg1glcZDbW2qpkUwx0cBWfNWlEWCUO8t0uc8j8z
	e8UmvGYZp6dxZhF+oVwKWVD6DI0VGmgywOr5EbTZzJ16McaU38bHtBK1dzMu
X-Google-Smtp-Source: AGHT+IH1e74czTT0tfNT2VrcgjToWEnoJUnxoIJhRxIQ347jPH4Mi9/t/0067L+0BBrcA+6It0YfJg==
X-Received: by 2002:a05:6602:27cf:b0:812:9c27:357c with SMTP id ca18e2360f4ac-81fd43652b4mr2874275139f.8.1723000910577;
        Tue, 06 Aug 2024 20:21:50 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a5c489sm2564597173.172.2024.08.06.20.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:21:50 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f8f0197abso60942839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:21:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcUFIV4eeVL+pZhMvv2kcBwX2W0JO8mpga7agjefg7z777wS62VNgr3F6tQw1c940pY3q9qKaROkqgNZxvKuhmLplPMdKdb4Fawl57
X-Received: by 2002:a92:d591:0:b0:39a:ea6a:9a82 with SMTP id
 e9e14a558f8ab-39b1fba1674mr197718075ab.13.1723000910171; Tue, 06 Aug 2024
 20:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726071023.4078055-1-lsahn@wewakecorp.com> <ZqY81pf9dvl6mvg9@kernel.org>
In-Reply-To: <ZqY81pf9dvl6mvg9@kernel.org>
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Wed, 7 Aug 2024 12:21:39 +0900
X-Gmail-Original-Message-ID: <CANTT7qg7JRZR0DpaUg_YFVTrbBDE9hrb_6bv4XDQ_3QXcgY_vw@mail.gmail.com>
Message-ID: <CANTT7qg7JRZR0DpaUg_YFVTrbBDE9hrb_6bv4XDQ_3QXcgY_vw@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: return right away if sparsemap_buf is null
To: Mike Rapoport <rppt@kernel.org>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:43, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Jul 26, 2024 at 04:10:23PM +0900, Leesoo Ahn wrote:
> > sparse_buffer_fini(..) takes the following actions even though the valu=
e of
> > sparsemap_buf is NULL,
> > 1. calculate size of sparsemap buffer (which is meaningless).
> > 2. set sparsemap_buf variable to NULL (although it is already NULL).
> >
> > These steps are unnecessary if the variable, sparsemap_buf is NULL.
> >
> > Refactor the function to return right away if the variable is NULL.
> > Hence, it doesn't need to take further actions.
>
> sparse_buffer_fini() is called a few times on init so saving a jump (if a=
t
> all) does not worth the churn.

Fair enough.

Any related to refactoring codebase will be unlikely to be taken into upstr=
eam??

BR,
Leesoo

