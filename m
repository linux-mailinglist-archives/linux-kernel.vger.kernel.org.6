Return-Path: <linux-kernel+bounces-243830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C02929B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709DD1F2155B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28266FC5;
	Mon,  8 Jul 2024 03:54:22 +0000 (UTC)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088679C2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410862; cv=none; b=X/9EJbdZzsWkWjNDfZDl0YVwRyPNABR5/6QCRMSZDVxoDcI10GRTggRImKyyNrycWCK/xCM8sbvTV8UCxYO/G+InRincN6zsJpIReEcE91oodmezdg7hoVpVp9OGnKdU61B5Rs3aBs+b8BO8uzuQj/QLNPy1XwRRLCnbDqWxF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410862; c=relaxed/simple;
	bh=NaOq+m3qxDJgD6VQ7cnj8T2proh7NlpW+jyR29fEDKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saecylTeay5GOTZpv7X4pKGBldksxLseHaupl+CXvJyk5RGrKNXjqCYM9LpId3jMUOq6mKEtVitYCr1nIdflDxfj/47e4UwCSEuUCcgUmOVktOgpkQeVVUdsWY5uznCXKOaubhTwg2Ru0uypGPfuA4zBHU/M6fmFnZVo1z5MR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f2ee3be492so883493e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 20:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720410859; x=1721015659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9yWBcvtrBN9A0bVR1CPLdm0pzTAqGp6O50VAnnxws8=;
        b=ePFDb1AzP+9zFzmpz4A9w4zojqylgrvhpsWqKm+xVo9JS+lI4YZxtUW0lYfpW3Vrrl
         T/27jjTzpIIOCbLmu78UHs7SxTsEwKUcDpIcE/5rbH0596LePO1Jqklo9BYRkBpcXWHD
         27ahAxdJ8kcNpBYcsEP1F8+oQLfInaWgoMahZ00+vVskryOaWjPc0Jt2g1Sj6YrfwU0u
         /qzbLV1ky9IDI3PvFbivCMTQGVuqDBJarSfpvjx4tn7/QhpO1aekiPaUug5ebnuAh+QO
         /48v0L8IxULp8kIIrS7Xvss7Z4p7FkudMm9b21anBmnjD7OYKgl7knPDji2e3Celo4Ku
         7VpA==
X-Forwarded-Encrypted: i=1; AJvYcCWV20OK2WHy/E4zFV1Z4nzE/z0sCabgb68yr0+67ekq1v/USs255usEd2yBQifl4PftF0sDIFEIVavEutZCoyNN+JB65A/5s8CxwRMQ
X-Gm-Message-State: AOJu0YwCub5ssEQ09dWaboI4zZYBzBZeSZ/ygyii6993ElV5qrMpB1YR
	SIAVYLSQ/plrpWeG6arYD12yitQmCo84sM9RWLr3U2ww4WuqN7+OEGd3YyyHQCPce0+Sn0b7mT8
	cJcau3fTWVPcH6Wo1c5SNifOI35Qdk+IM
X-Google-Smtp-Source: AGHT+IFxeWLfsOeL1l5WXfdLDl5BzX7i/gji+dB2rmBjloeQTwZGNNgUupfoYxsObbFscvI1xOnbiGQeRJ52fFSJwcE=
X-Received: by 2002:a05:6122:1693:b0:4f2:fc5c:b89 with SMTP id
 71dfb90a1353d-4f2fc5c0e14mr6120606e0c.15.1720410857835; Sun, 07 Jul 2024
 20:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221114904.1849-1-justinjiang@vivo.com> <CAGsJ_4ytMMbPo4EuNSQ-A75T+5h3O+nM127xcMg+QpKjf5D8Sg@mail.gmail.com>
 <7964fa25-0ba6-43b5-b215-4e381a355a08@vivo.com>
In-Reply-To: <7964fa25-0ba6-43b5-b215-4e381a355a08@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 15:54:06 +1200
Message-ID: <CAGsJ_4wik+oagod+WKJviavabqKQTDDWxPxUQJ1kS1JSPpA2Qw@mail.gmail.com>
Subject: Re: [PATCH] mm: shrink skip folio mapped by an exiting task
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:40=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/6/30 17:35, Barry Song =E5=86=99=E9=81=93:
> > [Some people who received this message don't often get email from baohu=
a@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]
> >
> > On Thu, Feb 22, 2024 at 12:49=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo=
.com> wrote:
> > This is clearly version 3, as you previously sent version 2, correct?
> Hi Barry,
>
> Yes, patchs are as follows:
> v3:
> https://lore.kernel.org/linux-mm/20240221114904.1849-1-justinjiang@vivo.c=
om/
> v2:
> https://lore.kernel.org/linux-mm/20240202012251.1aa5afbfdf2f8b3a862bced3@=
linux-foundation.org/
> v1:
> https://lore.kernel.org/linux-mm/20240124124308.461-1-justinjiang@vivo.co=
m/
> >
> >> If an anon folio reclaimed by shrink_inactive_list is mapped by an
> >> exiting task, this anon folio will be firstly swaped-out into
> >> swapspace in shrink flow and then this swap folio is freed in task
> >> exit flow. But if this folio mapped by an exiting task can skip
> >> shrink and be freed directly in task exiting flow, which will save
> >> swap-out time and alleviate the load of the tasks exiting process.
> >> The file folio is also similar.
> >>
> > Could you please describe the specific impact on users, including user
> > experience and power consumption? How serious is this problem?
> 1.At present, I do not have a suitable method to accurately measure the
> optimization benefit datas of this modifications, but I believe it
> theoretically
> has some benefits.
> 2.Launching large memory app (for example, starting the camera) in multip=
le
> backend scenes may result in the high cpu load of exiting processes.
> >
> >> And when system is low memory, it more likely to occur, because more
> >> backend applidatuions will be killed.
> > Applications?
> Yes.
> >
> >> This patch can alleviate the load of the tasks exiting process.
> > I'm not completely convinced this patch is correct, but it appears to b=
e
> > heading in the right direction. Therefore, I expect to see new versions
> > rather than it being dead.
> >
> >> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >> ---
> >>   mm/rmap.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>   mode change 100644 =3D> 100755 mm/rmap.c
> > You changed the file mode to 755, which is incorrect.
> >
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 3746a5531018..146e5f4ec069
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *fo=
lio,
> >>          int referenced =3D 0;
> >>          unsigned long start =3D address, ptes =3D 0;
> >>
> >> +       /* Skip this folio if it's mapped by an exiting task */
> >> +       if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
> >> +               unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) =
{
> >> +               pra->referenced =3D -1;
> > Why use -1? Is this meant to simulate lock contention to keep the folio=
 without
> > activating it?
> >
> >          /* rmap lock contention: rotate */
> >          if (referenced_ptes =3D=3D -1)
> >                  return FOLIOREF_KEEP;
> >
> > Please do have some comments to explain why.
> >
> > I'm not convinced this change is appropriate for shared folios. It seem=
s
> > more suitable for exclusive folios used solely by the exiting process.
> 1.The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacas=
e
> the folios will be freed soon in the exiting process flow.

This requires an explicit comment in the code. The expression
referenced_ptes =3D=3D -1
implies "rmap lock contention: rotate", but it appears that this is
not the case here. You
should either update the original comment to reflect the current logic
or use a different
value.

> 2.Yes, the shared folios can not be simply skipped. I have made relevant
> modifications in patch v4 and please help to further review.
> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.co=
m/
>
> Thanks
> Zhiguo
> >
> >
> >> +               return false;
> >> +       }
> >> +
> >>          while (page_vma_mapped_walk(&pvmw)) {
> >>                  address =3D pvmw.address;
> >>
> >> --
> >> 2.39.0
> >>
> > Thanks
> > Barry
>

