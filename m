Return-Path: <linux-kernel+bounces-303239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C1596096B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7171F219DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35E19EED8;
	Tue, 27 Aug 2024 11:59:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DB19D88C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759957; cv=none; b=My0BwurLpLFeU0Yk51JXLtAJswxIBoEVfCeCjmOQzvzLbtbBbWiUYGH9dXna7tTBjB4P06+8eYOICOwuzfAWiXVTHndx1sJsKWENljwvM0LB9nyIP7Yu5RMcqfSF8hlE1QZEVk9w42IAZR6Th42TPxN76+E+XUjeRaR7JDWSFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759957; c=relaxed/simple;
	bh=HksysG1xLCN+VLYDz1IdYYSqeiJYzIGslGvCfdijGUw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drutzbLmqpZZQvikvIxTC/D6rO6EvL28o0zCX/qIylejkzhz+kKMMNKcd7BKVw+qJMBVJFp88JJDzMI13+EN5u38UbG/1TATR5lGNIkPRv++GWCpeAzuaxU242ArNyNPvQugshLI3Ohdz1QuYMNRjyxNTSHNd3BIe6TiFBM2Nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtQw143fmz6J7Zj;
	Tue, 27 Aug 2024 19:55:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C2AE140B39;
	Tue, 27 Aug 2024 19:59:11 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 12:59:11 +0100
Date: Tue, 27 Aug 2024 12:59:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 6/6] soc: hisilicon: kunpeng_hccs: Support low power
 feature for the specified HCCS type
Message-ID: <20240827125910.00007cdd@Huawei.com>
In-Reply-To: <de0d4cb2-c668-1d7f-2893-a42840a2b53b@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
	<20240823031059.32579-1-lihuisong@huawei.com>
	<20240823031059.32579-7-lihuisong@huawei.com>
	<20240823095851.0000004e@Huawei.com>
	<de0d4cb2-c668-1d7f-2893-a42840a2b53b@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 19:48:32 +0800
"lihuisong (C)" <lihuisong@huawei.com> wrote:

> Hi Jonathan,
>=20
> Thanks for your review again.
> Your proposal are good and are also more worth to enhance code.
> How about use guard() for all sysfs interface in furture patch?
> I want to support this feature first.
Sure, that's fine and why I gave an RB tag even with comments.

Thanks,

Jonathan

>=20
> Huisong
>=20
>=20
> =E5=9C=A8 2024/8/23 16:58, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Fri, 23 Aug 2024 11:10:59 +0800
> > Huisong Li <lihuisong@huawei.com> wrote:
> > =20
> >> Add the low power feature for the specified HCCS type by increasing
> >> and decreasing the used lane number of these HCCS ports on platform.
> >>
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com> =20
> > Hi Huisong,
> >
> > A few comments inline, but all minor things.
> >
> > With at least the "none" string print dropped as it's in an error path
> > that shouldn't be hit you can add =20
> You are correct.
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The early return comment and whitespace suggestion are things you
> > can act on if you liek for v2.
> >
> > Jonathan
> > =20
> >> ---
> >>   .../sysfs-devices-platform-kunpeng_hccs       |  37 ++
> >>   drivers/soc/hisilicon/Kconfig                 |   7 +-
> >>   drivers/soc/hisilicon/kunpeng_hccs.c          | 378 ++++++++++++++++=
+-
> >>   drivers/soc/hisilicon/kunpeng_hccs.h          |  14 +
> >>   4 files changed, 433 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_=
hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
> >> index d4c355e0e0bb..d1b3a95a5518 100644
> >> --- a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
> >> +++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
> >> @@ -87,3 +87,40 @@ Contact:	Huisong Li <lihuisong@huawei.com>
> >>   Description:
> >>   		This interface is used to show all HCCS types used on the
> >>   		platform, like, HCCS-v1, HCCS-v2 and so on.
> >> +
> >> +What:		/sys/devices/platform/HISI04Bx:00/available_inc_dec_lane_types
> >> +What:		/sys/devices/platform/HISI04Bx:00/dec_lane_of_type
> >> +What:		/sys/devices/platform/HISI04Bx:00/inc_lane_of_type
> >> +Date:		August 2024
> >> +KernelVersion:	6.12
> >> +Contact:	Huisong Li <lihuisong@huawei.com>
> >> +Description:
> >> +		These interfaces under /sys/devices/platform/HISI04Bx/ are
> >> +		used to support the low power consumption feature of some
> >> +		HCCS types by changing the number of lanes used. The interfaces
> >> +		changing the number of lanes used are 'dec_lane_of_type' and
> >> +		'inc_lane_of_type' which require root privileges. These
> >> +		interfaces aren't exposed if no HCCS type on platform support
> >> +		this feature. Please note that decreasing lane number is only
> >> +		allowed if all the specified HCCS ports are not busy.
> >> +
> >> +		The low power consumption interfaces are as follows:
> >> +
> >> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +		available_inc_dec_lane_types: (RO) available HCCS types (string) to
> >> +						   increase and decrease the number
> >> +						   of lane used, e.g. HCCS-v2. =20
> > See below. There is an apparent value of 'none' available, but I think =
in reality the
> > interface doesn't exist if that is present. So drop it as it will just =
cause confusion. =20
> Ack
> > =20
> >> +		dec_lane_of_type:             (WO) input HCCS type supported
> >> +						   decreasing lane to decrease the
> >> +						   used lane number of all specified
> >> +						   HCCS type ports on platform to
> >> +						   the minimum.
> >> +						   You can query the 'cur_lane_num'
> >> +						   to get the minimum lane number
> >> +						   after executing successfully.
> >> +		inc_lane_of_type:             (WO) input HCCS type supported
> >> +						   increasing lane to increase the
> >> +						   used lane number of all specified
> >> +						   HCCS type ports on platform to
> >> +						   the full lane state.
> >> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +static int hccs_wait_serdes_adapt_completed(struct hccs_dev *hdev, u8=
 type)
> >> +{
> >> +#define HCCS_MAX_WAIT_CNT_FOR_ADAPT	10
> >> +#define HCCS_QUERY_ADAPT_RES_DELAY_MS	100
> >> +#define HCCS_SERDES_ADAPT_OK		0
> >> +
> >> +	struct hccs_inc_lane_req_param *req_param;
> >> +	u8 wait_cnt =3D HCCS_MAX_WAIT_CNT_FOR_ADAPT;
> >> +	struct hccs_desc desc;
> >> +	u8 adapt_res;
> >> +	int ret;
> >> +
> >> +	do {
> >> +		hccs_init_req_desc(&desc);
> >> +		req_param =3D (struct hccs_inc_lane_req_param *)desc.req.data;
> >> +		req_param->port_type =3D type;
> >> +		req_param->opt_type =3D HCCS_GET_ADAPT_RES;
> >> +		ret =3D hccs_pcc_cmd_send(hdev, HCCS_PM_INC_LANE, &desc);
> >> +		if (ret) {
> >> +			dev_err(hdev->dev, "query adapting result failed, ret =3D %d.\n",
> >> +				ret);
> >> +			return ret;
> >> +		}
> >> +		adapt_res =3D *((u8 *)&desc.rsp.data);
> >> +		if (adapt_res =3D=3D HCCS_SERDES_ADAPT_OK)
> >> +			break; =20
> > return 0; here perhaps? =20
>=20
> It's ok. And then we can directly return failure if timeout.
>=20
> > =20
> >> +
> >> +		msleep(HCCS_QUERY_ADAPT_RES_DELAY_MS);
> >> +	} while (--wait_cnt);
> >> +
> >> +	if (adapt_res !=3D HCCS_SERDES_ADAPT_OK) { =20
> > With above early exit in good path, this can be unconditional perhaps? =
=20
> Yes
> > =20
> >> +		dev_err(hdev->dev, "wait for adapting completed timeout.\n");
> >> +		return -ETIMEDOUT;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +static ssize_t inc_lane_of_type_store(struct kobject *kobj, struct ko=
bj_attribute *attr,
> >> +			      const char *buf, size_t count)
> >> +{
> >> +	struct hccs_dev *hdev =3D device_kobj_to_hccs_dev(kobj);
> >> +	bool full_lane;
> >> +	u8 port_type;
> >> +	int ret;
> >> +
> >> +	ret =3D hccs_parse_pm_port_type(hdev, buf, &port_type);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	mutex_lock(&hdev->lock); =20
> > Another comment for a future patch series perhaps.
> >
> > guard(mutex)(&hdev->lock); in all these will make the code quite a bit =
cleaner. =20
> This is a good way. very nice and simple.
> But many sysfs interfaces in this driver have used mutex_lock/mutex_unloc=
k.
> So is it better for us to keep the same mutex lock way in this patch and=
=20
> use guard() for all sysfs interface in furture patch?
> >> +	ret =3D hccs_get_all_spec_port_full_lane_sta(hdev, port_type, &full_=
lane);
> >> +	if (ret || full_lane)
> >> +		goto out;
> >> +
> >> +	ret =3D hccs_start_inc_lane(hdev, port_type);
> >> +out:
> >> +	mutex_unlock(&hdev->lock);
> >> +	return ret =3D=3D 0 ? count : ret;
> >> +}
> >> +static struct kobj_attribute inc_lane_of_type_attr =3D
> >> +		__ATTR(inc_lane_of_type, 0200, NULL, inc_lane_of_type_store);
> >> +
> >> +static ssize_t available_inc_dec_lane_types_show(struct kobject *kobj,
> >> +						 struct kobj_attribute *attr,
> >> +						 char *buf)
> >> +{
> >> +	struct hccs_dev *hdev =3D device_kobj_to_hccs_dev(kobj);
> >> +
> >> +	if (hdev->caps & HCCS_CAPS_HCCS_V2_PM)
> >> +		return sysfs_emit(buf, "%s\n",
> >> +				  hccs_port_type_to_name(hdev, HCCS_V2));
> >> +
> >> +	return sysfs_emit(buf, "%s\n", "none"); =20
> > Can we get here? I thought this was only registered if the condition
> > above is true?
> >
> > Maybe worth keeping a fallback here as a code hardening measure, but
> > perhaps return -EINVAL; is fine? =20
> Ack
> >
> > =20
> >> +}
> >> +static struct kobj_attribute available_inc_dec_lane_types_attr =3D
> >> +		__ATTR(available_inc_dec_lane_types, 0444,
> >> +		       available_inc_dec_lane_types_show, NULL);
> >>  =20
> >>   static ssize_t used_types_show(struct kobject *kobj,
> >>   			       struct kobj_attribute *attr, char *buf)
> >> @@ -1215,11 +1553,49 @@ static struct kobj_attribute used_types_attr =
=3D
> >>   static void hccs_remove_misc_sysfs(struct hccs_dev *hdev)
> >>   {
> >>   	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
> >> +
> >> +	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
> >> +		return;
> >> +
> >> +	sysfs_remove_file(&hdev->dev->kobj,
> >> +			  &available_inc_dec_lane_types_attr.attr);
> >> +	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_of_type_attr.attr);
> >> +	sysfs_remove_file(&hdev->dev->kobj, &inc_lane_of_type_attr.attr);
> >>   }
> >>  =20
> >>   static int hccs_add_misc_sysfs(struct hccs_dev *hdev)
> >>   {
> >> -	return sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
> >> +	int ret;
> >> +
> >> +	ret =3D sysfs_create_file(&hdev->dev->kobj, &used_types_attr.attr);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (!(hdev->caps & HCCS_CAPS_HCCS_V2_PM))
> >> +		return 0;
> >> +
> >> +	ret =3D sysfs_create_file(&hdev->dev->kobj,
> >> +				&available_inc_dec_lane_types_attr.attr);
> >> +	if (ret)
> >> +		goto used_types_remove;
> >> +
> >> +	ret =3D sysfs_create_file(&hdev->dev->kobj, &dec_lane_of_type_attr.a=
ttr);
> >> +	if (ret)
> >> +		goto inc_dec_lane_types_remove; =20
> > I can sort of see why no line break makes some sense here given these
> > two files are closely related, but I'd still add one here as I think
> > visual consistency is more important for readability reasons. =20
> Ack
> > =20
> >> +	ret =3D sysfs_create_file(&hdev->dev->kobj, &inc_lane_of_type_attr.a=
ttr);
> >> +	if (ret)
> >> +		goto dec_lane_of_type_remove;
> >> +
> >> +	return 0;
> >> +
> >> +dec_lane_of_type_remove:
> >> +	sysfs_remove_file(&hdev->dev->kobj, &dec_lane_of_type_attr.attr);
> >> +inc_dec_lane_types_remove:
> >> +	sysfs_remove_file(&hdev->dev->kobj,
> >> +			  &available_inc_dec_lane_types_attr.attr);
> >> +used_types_remove:
> >> +	sysfs_remove_file(&hdev->dev->kobj, &used_types_attr.attr);
> >> +	return ret;
> >>   }
> >>  =20
> >>   static void hccs_remove_die_dir(struct hccs_die_info *die) =20
> > . =20


